//
//  TablePresenter.swift
//  PresenterViperMovieDB
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation

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
    
    func getNumberOfSections() -> Int {
        return 0
    }
    
    func getNumberOfRows(for: Int) -> Int {
        return 0
    }
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity {
        return MovieEntity(name: "", overview: "", rating: "", genres: [], genresIds: [], urlPath: "")
    }
    
    func touchedCellAt(indexPath: IndexPath) {
        
    }
    
    func getNextPage() {
        
    }
    
}
