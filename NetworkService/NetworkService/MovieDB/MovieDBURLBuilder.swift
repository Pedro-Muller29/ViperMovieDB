//
//  BaseMovieDBURL.swift
//  NetworkingService
//
//  Created by Gabriel Medeiros Martins on 19/03/24.
//

import Foundation

public enum MovieDBURLRequestBuilder {
    public enum ImageSize {
        case width(Int)
        case height(Int)
        case original
        
        var appendage: String {
            switch self {
            case .width(let width):
                return "/w\(width)/"
            case .height(let height):
                return "/h\(height)/"
            case .original:
                return "/original/"
            }
        }
    }
    
    public enum MovieCategory {
        case popular
        case topRated
        case details(_ id: Int)
        
        var appendage: String {
            switch self {
            case .popular:
                return "popular"
            case .topRated:
                return "top_rated"
            case .details(let id):
                return "\(id)"
            }
        }
    }
    
    case movie(category: MovieCategory, page: Int?)
    case image(size: ImageSize, appendage: String)
    case genre
    
    static private let movieURL: String = "https://api.themoviedb.org/3/movie/"
    static private let imageURL: String = "https://image.tmdb.org/t/p/"
    static private let genreURL: String = "https://api.themoviedb.org/3/genre/movie/list"
    
    static let headers = [
        "accept": "application/json",
        "Authorization": movieDBToken
    ]
    
    public var request: URLRequest? {
        switch self {
        case let .movie(category, page):
            guard let url = URL(string: "\(Self.movieURL)\(category.appendage)\(page != nil ? "&page=\(page!)" : "")") else { return nil }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = Self.headers
            return request
        case let .image(size, appendage):
            guard let url = URL(string: "\(Self.imageURL)/\(size.appendage)/\(appendage)") else { return nil }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = Self.headers
            return request
        case .genre:
            guard let url = URL(string: Self.genreURL) else { return nil }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = Self.headers
            return request
        }
    }
}
