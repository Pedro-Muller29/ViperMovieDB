//
//  TablePresenter.swift
//  PresenterViperMovieDB
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation



protocol AnyPresenter {
    associatedtype InteractorProtocol where InteractorProtocol: AnyInteractor
    
    associatedtype RouterProtocol where RouterProtocol: AnyRouter
    
    associatedtype ViewProtocol where ViewProtocol: AnyView
    
    var iteractor: InteractorProtocol? { get set }
    
    var router: RouterProtocol? { get set }
    
    var view: ViewProtocol? { get set }
}

protocol TablePresenterProtocol: AnyPresenter {
    var page: Int { get set }
    
    var entities: [any Entity] { get set }
    
    func getNumberOfSections() -> Int
    
    func getNumberOfRows(for: Int) -> Int
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity
    
    func touchedCellAt(indexPath: IndexPath)
    
    func getNextPage() async
    
}

class TablePresenter: TablePresenterProtocol {    
    var iteractor: InteractorMovie?
    var router: Router?
    var view: View?
    
    internal var page: Int = 0
    
    internal var entities: [any Entity] = []
    
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
    
    func getNextPage() async {
        
    }
    
    init(iteractor: InteractorProtocol, router: RouterProtocol, view: ViewProtocol, page: Int, entities: [any Entity]) {
        self.iteractor = iteractor
        self.router = router
        self.view = view
        self.page = page
        self.entities = entities
    }
}
