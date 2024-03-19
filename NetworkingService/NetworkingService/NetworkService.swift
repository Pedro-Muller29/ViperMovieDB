//
//  NetworkService.swift
//  NetworkingService
//
//  Created by Gabriel Medeiros Martins on 19/03/24.
//

import Foundation

public struct NetworkService {
    public static func fetch(request: URLRequest, completion: @escaping (Result<Data, any Error>) -> ()) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(URLError(.badServerResponse)))
            }
            
            return completion(.success(data))
        }
        .resume()
    }
    
    public static func fetch<T>(request: URLRequest, completion: @escaping (Result<[T], any Error>) -> ()) where T : Decodable, T : Encodable {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(URLError(.badServerResponse)))
            }
            
            do {
                let parsedData = (try JSONSerialization.jsonObject(with: data)) as? [String : Any]
                guard let arrays = parsedData?.values.compactMap({ value in (value as? NSArray) }) else {
                    return completion(.failure(URLError(.downloadDecodingFailedToComplete)))
                }
                
                for array in arrays {
                    let dicts = array.compactMap { element in
                        element as? [String : Any]
                    }
                    
                    let newData = try JSONSerialization.data(withJSONObject: dicts, options: [.sortedKeys, .withoutEscapingSlashes])
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let result = try decoder.decode([T].self, from: newData)
                    return completion(.success(result))
                }
                
            } catch let er as DecodingError {
                return completion(.failure(URLError(.downloadDecodingFailedToComplete)))
            } catch {
                return completion(.failure(URLError(.unknown)))
            }
        }
        .resume()
    }
    
    public static func fetch<T>(request: URLRequest, completion: @escaping (Result<T, any Error>) -> ()) where T : Decodable, T : Encodable {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(URLError(.badServerResponse)))
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                
            } catch let er as DecodingError {
                return completion(.failure(URLError(.downloadDecodingFailedToComplete)))
            } catch {
                return completion(.failure(URLError(.unknown)))
            }
        }
        .resume()
    }
}
