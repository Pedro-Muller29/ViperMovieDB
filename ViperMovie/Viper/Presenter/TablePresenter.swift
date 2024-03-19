//
//  TablePresenter.swift
//  PresenterViperMovieDB
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation

public protocol TablePresenterProtocol: AnyPresenter {
    var iteractor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
    var view: AnyView? { get set }
    
    func getNumberOfSections() -> Int
    
    func getNumberOfRows(for: Int) -> Int
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity
    
    func touchedCellAt(indexPath: IndexPath)
    
    func getNextPage()
    
}

public class TablePresenter: TablePresenterProtocol {
    public var iteractor: AnyInteractor?
    public var router: AnyRouter?
    public var view: AnyView?
    
    public func getNumberOfSections() -> Int {
        return 0
    }
    
    public func getNumberOfRows(for: Int) -> Int {
        return 0
    }
    
    public func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity {
        return MovieEntity(name: "", overview: "", rating: 0.0, genres: [], genreIds: [], urlPath: "")
    }
    
    public func touchedCellAt(indexPath: IndexPath) {
        
    }
    
    public func getNextPage() {
        
    }
    
}
