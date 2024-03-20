//
//  AnyView.swift
//  UIComponentsMovieDBViper
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation

protocol AnyView {
    associatedtype PresenterProtocol where PresenterProtocol: AnyPresenter
    var presenter: PresenterProtocol? { get set }
    func update()
}

class View: AnyView {
    var presenter: TablePresenter?
    
    init(presenter: PresenterProtocol? = nil) {
        self.presenter = presenter
    }
    
    func update() {
    }
}
