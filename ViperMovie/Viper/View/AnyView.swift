//
//  AnyView.swift
//  UIComponentsMovieDBViper
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation

public protocol AnyView {
    associatedtype Presenter: AnyPresenter
    var presenter: Presenter? { get set }
    
    func update()
}
