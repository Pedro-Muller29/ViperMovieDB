//
//  AnyView.swift
//  UIComponentsMovieDBViper
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation

protocol AnyView {
    associatedtype PresenterProtocol = any AnyPresenter
    var presenter: PresenterProtocol? { get set }
    func update()
}

protocol TableView: AnyView {
    associatedtype PresenterProtocol = any TablePresenterProtocol
}
