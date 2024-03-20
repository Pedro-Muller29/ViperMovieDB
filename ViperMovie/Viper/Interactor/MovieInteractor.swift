//
//  MovieInteractor.swift
//  ViperMovie
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation
import NetworkService


protocol AnyInteractor {
    associatedtype PresenterProtocol where PresenterProtocol: AnyPresenter
    var presenter: PresenterProtocol? { get set }
}



protocol InteractorMovieProtocol: AnyInteractor {
    var network: NetworkService? { get set }
    var entities: [Entity] { get set }
    func getNextPage(page: Int) async -> [MovieEntity]
}

class InteractorMovie: InteractorMovieProtocol {
    
    var presenter: TablePresenter?
    
    var network: NetworkService?
    
    var entities: [Entity] = []
    
    func getNextPage(page: Int) async -> [MovieEntity] {
        return []
    }
    
}
