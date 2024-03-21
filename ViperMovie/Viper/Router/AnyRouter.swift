//
//  AnyRouter.swift
//  RouterViperMovieDB
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation
import UIKit

typealias EntryPoint = (any UIViewController & AnyView )

protocol AnyRouter {
    var entry: EntryPoint? { get set }
    static func start() -> AnyRouter
}

