//
//  AnyView.swift
//  UIComponentsMovieDBViper
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation

public protocol AnyView {
    associatedtype PresenterProtocol: AnyPresenter
    var presenter:  PresenterProtocol? { get set }
    
    func update()
}

//class View: AnyView {
//    var presenter: AnyPresenter?
//    
//   // var presenter: TablePresenter?
//    
//    init(presenter: AnyPresenter? = nil) {
//        self.presenter = presenter
//    }
//    
//    func update() {
//    }
//}
