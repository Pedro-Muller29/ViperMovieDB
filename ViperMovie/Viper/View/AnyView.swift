//
//  AnyView.swift
//  UIComponentsMovieDBViper
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation

public protocol AnyView {
    var presenter: AnyPresenter? { get set }
}
