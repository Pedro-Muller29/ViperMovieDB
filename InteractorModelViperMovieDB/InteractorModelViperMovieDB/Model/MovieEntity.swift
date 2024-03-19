//
//  MovieEntity.swift
//  MovieDBViper
//
//  Created by Pedro Mezacasa Muller on 19/03/24.
//

import Foundation

struct MovieEntity: Entity {
    var name: String
    var overview: String
    var rating: String
    var genres: [String]
    var image: Data?
    var urlPath: String
}
