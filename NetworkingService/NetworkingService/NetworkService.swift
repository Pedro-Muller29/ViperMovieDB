//
//  NetworkService.swift
//  NetworkingService
//
//  Created by Gabriel Medeiros Martins on 19/03/24.
//

import Foundation

protocol NetworkService {
    static func fetch(url: URLRequest, completion: @escaping (Data) -> ())
    
    static func fetch<T>(url: URLRequest, completion: @escaping ([T]) -> ()) where T: Codable
    
    static func fetch<T>(url: URLRequest, completion: @escaping (T) -> ()) where T: Codable
}
