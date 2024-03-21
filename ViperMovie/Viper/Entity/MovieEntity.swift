//
//  MovieEntity.swift
//  MovieDBViper
//
//  Created by Pedro Mezacasa Muller on 19/03/24.
//

import Foundation

class MovieEntity: Entity, Codable {
    private enum CodingKeys: String, CodingKey {
        case name = "title"
        case overview
        case rating = "vote_average"
        case genreIds = "genre_ids"
        case urlPath = "poster_path"
    }
    
    var name: String
    var overview: String
    var rating: Float
    var genres: [String] = []
    var genreIds: [Int]
    var image: Data? = nil
    var urlPath: String
}
