//
//  Entity.swift
//  MovieDBViper
//
//  Created by Pedro Mezacasa Muller on 19/03/24.
//

import Foundation

public protocol Entity {
    var name: String { get }
    var overview: String { get }
    var rating: String { get }
    var genres: [String] { get }
    var image: Data? { get }
}
