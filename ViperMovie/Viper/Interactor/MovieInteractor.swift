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
    var sections: [SectionTable] { get set }
    func getNextPage(page: Int, completion: @escaping([MovieEntity]) -> Void)
}

class InteractorMovie: InteractorMovieProtocol {
    
    var presenter: TablePresenter?
    
    var network: NetworkService?
    
    var sections: [SectionTable] = []
    
    func getNextPage(page: Int, completion: @escaping([MovieEntity]) -> Void) {
        guard let request = MovieDBURLRequestBuilder.movie(category: .popular, page: page).request else { return }
        NetworkService.fetch(request: request) { (result: Result<[MovieEntity], any Error>) in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                completion([])
            }
        }
    }
}
