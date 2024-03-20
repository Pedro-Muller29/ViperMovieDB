//
//  AnyPresenter.swift
//  PresenterViperMovieDB
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation


public protocol AnyPresenter {
    var iteractor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
    var view: (any AnyView)? { get set }
}
