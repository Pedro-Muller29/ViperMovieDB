//
//  BaseMovieDBURL.swift
//  NetworkingService
//
//  Created by Gabriel Medeiros Martins on 19/03/24.
//

import Foundation

enum BaseMovieDBURL {
    enum ImageSize {
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
    
    enum MovieCategory {
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
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTUwZjM0NWZlODRhMWNmNDJkZmRiYzYwNWIzMWY5NyIsInN1YiI6IjY0MjU4YjIyYzA0NDI5MDI2YjEyMzgzMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xeFA-BsIoEqdydWz3oKIWVdZ65sUeucX_fRvRGftuPs"
    ]
    
    var url: URL? {
        switch self {
        case let .movie(category, page):
            return URL(string: "\(Self.movieURL)\(category.appendage)\(page != nil ? "&page=\(page!)" : "")")
        case let .image(size, appendage):
            return URL(string: "\(Self.imageURL)/\(size.appendage)/\(appendage)")
        case .genre:
            return URL(string: Self.genreURL)
        }
    }
}
