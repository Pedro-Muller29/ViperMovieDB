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
    
    var sections: [SectionTable] { get set }
    
    func getNumberOfSections() -> Int
    
    func getNumberOfRows(sectionNumber: Int) -> Int
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity
    
    func touchedCellAt(indexPath: IndexPath)
    
    func getNextPage() async
    
}

class TablePresenter: TablePresenterProtocol {    
    var iteractor: InteractorMovie?
    var router: Router?
    var view: View?
    
    internal var page: Int = 1
    
    internal var sections: [SectionTable] = []
    
    func getNumberOfSections() -> Int {
        return sections.count
    }
    
    func getNumberOfRows(sectionNumber: Int) -> Int {
        return sections[sectionNumber].entities.count
    }
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity {
        return MovieEntity(name: "Carros 2", overview: "Baita filme", rating: 1.0, genres: [], genreIds: [], urlPath: "")
    }
    
    func touchedCellAt(indexPath: IndexPath) {
        
    }
    
    func refreshTableContent() {
        
    }
    
    func getNextPage() async {
        
    }
    
    init(iteractor: InteractorProtocol, router: RouterProtocol, view: ViewProtocol, page: Int, sections: [SectionTable]) {
        self.iteractor = iteractor
        self.router = router
        self.view = view
        self.page = page
        self.sections = sections
    }
}
