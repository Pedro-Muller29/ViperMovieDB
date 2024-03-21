//
//  TableStruct.swift
//  ViperMovie
//
//  Created by Joao Paulo Carneiro on 20/03/24.
//

import Foundation
import NetworkService

struct SectionTable<T> where T: Entity {
    var name: String
    var page: Int
    var entities: [T]
}
