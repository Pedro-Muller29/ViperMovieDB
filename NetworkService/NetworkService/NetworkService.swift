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
            print(1)
            guard let data = data else {
                return completion(.failure(URLError(.badServerResponse)))
            }
            print("2")
            do {
                let parsedData = (try JSONSerialization.jsonObject(with: data)) as? [String : Any]
                print(3)
                guard let arrays = parsedData?.values.compactMap({ value in (value as? NSArray) }) else {
                    print("MERDA AQUI 1")
                    return completion(.failure(URLError(.downloadDecodingFailedToComplete)))
                }
                print(4)
                for array in arrays {
                    print("Entrando no array 1")
                    let dicts = array.compactMap { element in
                        element as? [String : Any]
                    }
                    print("Entrando no array 2")
                    let newData = try JSONSerialization.data(withJSONObject: dicts, options: [.sortedKeys, .withoutEscapingSlashes])
                    print("Entrando no array 3")
                    let decoder = JSONDecoder()
                    print("Entrando no array 4")
                    let result = try decoder.decode([T].self, from: newData)
                    print("Entrando no array 5")
                    return completion(.success(result))
                }
                
                if arrays.isEmpty {
                    completion(.failure(URLError(.downloadDecodingFailedToComplete)))
                }
                
            } catch let err as DecodingError {
                print("JORGE 1", err)
                return completion(.failure(URLError(.downloadDecodingFailedToComplete)))
            } catch {
                print("JORGE 2")
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
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                
            } catch _ as DecodingError {
                return completion(.failure(URLError(.downloadDecodingFailedToComplete)))
            } catch {
                return completion(.failure(URLError(.unknown)))
            }
        }
        .resume()
    }
}



/*
{
    "page": 1,
    "results": [
        {
            "adult": false,
            "backdrop_path": "/6feb1sjJdNvXQJXw9n6G07SZIR3.jpg",
            "genre_ids": [
                35,
                18,
                14
            ],
            "id": 271388,
            "original_language": "es",
            "original_title": "Velociraptor",
            "overview": "During the end of the world, two best friends walk around their city, talking about their sex lives, and one of them reveals they are still a virgin.",
            "popularity": 2.59,
            "poster_path": "/mGuQBdevB7q2JK6PMqYjCVrXN8W.jpg",
            "release_date": "2014-06-07",
            "title": "Velociraptor",
            "video": false,
            "vote_average": 5.2,
            "vote_count": 16
        },
        {
            "adult": false,
            "backdrop_path": "/76ZeLcsivMqAUuWO4tGXuOjUFVh.jpg",
            "genre_ids": [
                53,
                9648,
                80,
                27
            ],
            "id": 30689,
            "original_language": "it",
            "original_title": "4 mosche di velluto grigio",
            "overview": "Roberto, a drummer in a rock band, keeps receiving weird phone calls and being followed by a mysterious man. One night he manages to catch up with his persecutor and tries to get him to talk but in the ensuing struggle he accidentally stabs him. He runs away, but he understands his troubles have just begun when the following day he receives an envelope with photos of him killing the man. Someone is killing all his friends and trying to frame him for the murders.",
            "popularity": 12.464,
            "poster_path": "/hEFlF2M4nJ9OszjZaJ2oaRt9lr0.jpg",
            "release_date": "1971-12-17",
            "title": "Four Flies on Grey Velvet",
            "video": false,
            "vote_average": 6.503,
            "vote_count": 353
        }
    ]
}
*/
