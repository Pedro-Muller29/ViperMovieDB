//
//  MovieDBHandler.swift
//  NetworkingService
//
//  Created by Gabriel Medeiros Martins on 19/03/24.
//

import Foundation

struct Genre: Codable {
    var id: Int
    var name: String
}

struct Movie: Codable {
    private enum CodingKeys : String, CodingKey {
        case id, title, overview, voteAverage, runtime, budget, revenue, releaseDate, posterPath, genreIds
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    
    var title: String
    var overview: String

    var voteAverage: Float

    var runtime: Int?
    
    var budget: Int?
    var revenue: Int?

    var releaseDate: String
    
    var imageData: Data?
    var posterPath: String
    
    var genres: [Genre] = []
    var genreIds: [Int]?
}

class MovieDBService {
    
}

/*
 struct NetworkService {
     static func fetch(url: BaseApiURL, completion: @escaping (Data) -> ()) {
         guard let url = url.url else {
             print("Invalid URL.")
             return
         }
         
         var request = URLRequest(url: url)
         request.allHTTPHeaderFields = BaseApiURL.headers
         
         URLSession.shared.dataTask(with: request) { data, response, error in
             guard let data = data, error == nil else {
                 print("Failed to fetch data:")
                 print(error as Any)
                 return
             }
             
             completion(data)
         }
         .resume()
     }
     
     static func fetch<T>(url: BaseApiURL, completion: @escaping ([T]) -> ()) where T: Codable {
         guard let url = url.url else {
             print("Invalid URL.")
             return
         }
         
         var request = URLRequest(url: url)
         request.allHTTPHeaderFields = BaseApiURL.headers
         
         URLSession.shared.dataTask(with: request) { data, response, error in
             guard let data = data, error == nil else {
                 print("Failed to fetch data:")
                 print(error as Any)
                 return
             }
             
             do {
                 let parsedData = (try JSONSerialization.jsonObject(with: data)) as? [String : Any]
                 guard let arrays = parsedData?.values.compactMap({ value in (value as? NSArray) }) else {
                     print("Failed to find an array of \(T.self).")
                     return
                 }
                 
                 for array in arrays {
                     let dicts = array.compactMap { element in
                         element as? [String : Any]
                     }
                     
                     let newData = try JSONSerialization.data(withJSONObject: dicts, options: [.sortedKeys, .withoutEscapingSlashes])
                     
                     let decoder = JSONDecoder()
                     decoder.keyDecodingStrategy = .convertFromSnakeCase
                     
                     let result = try decoder.decode([T].self, from: newData)
                     completion(result)
                 }
             } catch let er as DecodingError {
                 print("Failed to decode data:")
                 print(er)
                 
             } catch {
                 print("Unknown error.")
             }
         }.resume()
     }
     
     static func fetch<T>(url: BaseApiURL, completion: @escaping (T) -> ()) where T: Codable {
         guard let url = url.url else {
             print("Invalid URL.")
             return
         }
         
         var request = URLRequest(url: url)
         request.allHTTPHeaderFields = BaseApiURL.headers
         
         URLSession.shared.dataTask(with: request) { data, response, error in
             guard let data = data, error == nil else {
                 print("Failed to fetch data:")
                 print(error as Any)
                 return
             }
             
             let decoder = JSONDecoder()
             decoder.keyDecodingStrategy = .convertFromSnakeCase
             
             do {
                 let decodedData = try decoder.decode(T.self, from: data)
                 completion(decodedData)
             } catch let er as DecodingError {
                 print("Failed to decode data:")
                 print(er)
             } catch {
                 print("Unknown error.")
             }
             
         }.resume()
     }
 }
*/
