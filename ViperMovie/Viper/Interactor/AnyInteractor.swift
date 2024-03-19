//
//  AnyInteractor.swift
//  InteractorModelViperMovieDB
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation


public protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
}
