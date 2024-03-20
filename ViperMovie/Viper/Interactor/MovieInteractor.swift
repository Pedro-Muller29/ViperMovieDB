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
    
    weak var presenter: TablePresenter?
    
    var network: NetworkService?
    
    var sections: [SectionTable] = []
    
    func refreshData() {
        self.sections = []
        let dispatchGroup = DispatchGroup()
        guard let requestNowPlaying = MovieDBURLRequestBuilder.movie(category: .nowPlaying, page: 1).request else { return }
        dispatchGroup.enter()
        NetworkService.fetch(request: requestNowPlaying) { (result: Result<[MovieEntity], any Error>) in
            var movies: [MovieEntity] = []
            switch result {
            case .success(let success):
                movies = success
            case .failure(_):
                break
            }
            self.sections.append(SectionTable(name: "Now Playing", page: 1, entities: movies))
            dispatchGroup.leave()
        }
        
        guard let requestPopular = MovieDBURLRequestBuilder.movie(category: .popular, page: 1).request else { return }
        dispatchGroup.enter()
        NetworkService.fetch(request: requestPopular) { (result: Result<[MovieEntity], any Error>) in
            var movies: [MovieEntity] = []
            switch result {
            case .success(let success):
                movies = success
            case .failure(_):
                break
            }
            self.sections.insert(SectionTable(name: "Popular Movies", page: 1, entities: movies), at: 0)
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .global(qos: .userInteractive)) {
            self.presenter?.reloadSections(newSections: self.sections)
        }
    }
    
    
    func getNextPage(page: Int, completion: @escaping([MovieEntity]) -> Void) {
        guard let request = MovieDBURLRequestBuilder.movie(category: .nowPlaying, page: page).request else { return }
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
