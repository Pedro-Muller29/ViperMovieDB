//
//  Entity.swift
//  MovieDBViper
//
//  Created by Pedro Mezacasa Muller on 19/03/24.
//

import Foundation

protocol Entity {
    var name: String { get }
    var overview: String { get }
    var rating: Float { get }
    var genres: [String] { get }
    var image: Data? { get }
}


