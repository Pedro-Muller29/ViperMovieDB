//
//  TablePresenter.swift
//  PresenterViperMovieDB
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation
import NetworkService

protocol TablePresenterProtocol: AnyPresenter {
    var iteractor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
    var view: (any AnyView)? { get set }
    
    func getNumberOfSections() -> Int
    
    func getNumberOfRows(for: Int) -> Int
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity
    
    func touchedCellAt(indexPath: IndexPath)
    
    func getNextPage()
    
}

class TablePresenter: TablePresenterProtocol {
    var iteractor: AnyInteractor?
    var router: AnyRouter?
    var view: (any AnyView)?
    
    lazy var array: [MovieEntity] = {
        guard let request = MovieDBURLRequestBuilder.movie(category: .popular, page: 1).request else { return [] }
        NetworkService.fetch(request: request) { (result: Result<[MovieEntity], any Error>) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    self.array = success
                    print(success.count)
                    self.view?.update()
                case .failure(let failure):
                    return
                }
            }
        }
        return []
    }()
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getNumberOfRows(for: Int) -> Int {
        return array.count
    }
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity {
        return array[indexPath.row]
    }
    
    func touchedCellAt(indexPath: IndexPath) {
        
    }
    
    func getNextPage() {
        
    }
    
}
