//
//  MovieInteractor.swift
//  ViperMovie
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation
import NetworkService

class CachedEntryObject: NSObject {
    var data: Data
    init(data: Data) {
        self.data = data
    }
}

protocol AnyInteractor {
   associatedtype PresenterProtocol where PresenterProtocol: AnyPresenter
    var presenter: PresenterProtocol? { get set }
}

protocol InteractorMovieProtocol: AnyInteractor {
    associatedtype EntityType where EntityType: Entity
    var imagesCached: NSCache<NSString, CachedEntryObject> {get set}
    var network: NetworkService? { get set }
    
    var sections: [SectionTable<EntityType>] { get set }
    
    func getNextPage(page: Int, search: String, completion: @escaping([MovieEntity]) -> Void)
}


class InteractorMovie: InteractorMovieProtocol {
    weak var presenter: TablePresenter<MovieEntity>?
    
    var network: NetworkService?
    
    var sections: [SectionTable<MovieEntity>] = []
    
    var imagesCached = NSCache<NSString, CachedEntryObject>()
    
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
                self.sections.append(SectionTable(name: "Now Playing", page: 1, entities: movies))
                dispatchGroup.leave()
                for movie in success {
                    self.getImageLocal(urlPath: movie.urlPath) { data in
                        guard let data = data else { return }
                        movie.image = data
                        self.presenter?.updateView()
                    }
                }
            case .failure(_):
                self.sections.append(SectionTable(name: "Now Playing", page: 1, entities: movies))
                dispatchGroup.leave()
            }
        }
        
        guard let requestPopular = MovieDBURLRequestBuilder.movie(category: .popular, page: 1).request else { return }
        dispatchGroup.enter()
        NetworkService.fetch(request: requestPopular) { (result: Result<[MovieEntity], any Error>) in
            var movies: [MovieEntity] = []
            switch result {
            case .success(let success):
                movies = success
                self.sections.insert(SectionTable(name: "Popular Movies", page: 1, entities: movies), at: 0)
                dispatchGroup.leave()
                for movie in success {
                    self.getImageLocal(urlPath: movie.urlPath) { data in
                        guard let data = data else { return }
                        movie.image = data
                        self.presenter?.updateView()
                    }
                }
            case .failure(_):
                self.sections.insert(SectionTable(name: "Popular Movies", page: 1, entities: movies), at: 0)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .global(qos: .userInteractive)) {
            self.presenter?.reloadSections(newSections: self.sections)
        }
    }
    
    func getNextPage(page: Int, search: String, completion: @escaping([MovieEntity]) -> Void) {
        if search.isEmpty {
            guard let request = MovieDBURLRequestBuilder.movie(category: .nowPlaying, page: page).request else { return }
            NetworkService.fetch(request: request) { (result: Result<[MovieEntity], any Error>) in
                switch result {
                case .success(let success):
                    for movie in success {
                        self.getImageLocal(urlPath: movie.urlPath) { data in
                            guard let data = data else { return }
                            movie.image = data
                            self.presenter?.updateView()
                        }
                    }
                    completion(success)
                case .failure(_):
                    completion([])
                }
            }
        } else {
            // TODO: PENDENTE PEGAR COM O GABRIEL O ENDPOINT DO URL BUILDER. E IMPLEMENTAR A CHAMADA
//            guard let request = MovieDBURLRequestBuilder
        }
    }
    
    private func requestImageRemote(urlPath: String, completion: @escaping (Data?) -> Void) {
        guard let url = MovieDBURLRequestBuilder.image(size: .height(100), appendage: urlPath).request else { return }
        NetworkService.fetch(request: url) { (result: Result<Data, any Error>) in
            switch result {
                case .success(let data):
                self.imagesCached.setObject(CachedEntryObject(data: data), forKey: NSString(string: urlPath))
                completion(data)
                case .failure(_):
                completion(nil)
            }
        }
    }
    
    private func getImageLocal(urlPath: String, completion: @escaping(Data?) -> ()) {
        if let data = self.imagesCached.object(forKey: NSString(string: urlPath)) {
            completion(data.data)
        } else {
            self.requestImageRemote(urlPath: urlPath) { data in
                if let data = self.imagesCached.object(forKey: NSString(string: urlPath)) {
                    completion(data.data)
                } else { 
                    completion(nil)
                }
            }
        }
    }
}
