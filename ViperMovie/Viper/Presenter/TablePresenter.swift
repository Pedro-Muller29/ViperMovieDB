//
//  TablePresenter.swift
//  PresenterViperMovieDB
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation
import NetworkService


protocol AnyPresenter: AnyObject {
    associatedtype InteractorProtocol where InteractorProtocol: AnyInteractor
    
    associatedtype RouterProtocol where RouterProtocol: AnyRouter
    
    associatedtype ViewProtocol where ViewProtocol: AnyView
    
    var iteractor: InteractorProtocol? { get set }
    
    var router: RouterProtocol? { get set }
    
    var view: ViewProtocol? { get set }
}

protocol TablePresenterProtocol: AnyPresenter {
    var sections: [SectionTable] { get set }
    
    func getNumberOfSections() -> Int
    
    func getNumberOfRows(sectionNumber: Int) -> Int
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity
    
    func touchedCellAt(indexPath: IndexPath)
    
    func getNextPage() async
    
    func refreshTableContent()
    
    func titleForSection(section: Int) -> String
}

class TablePresenter: TablePresenterProtocol {
    var iteractor: InteractorMovie?
    var router: TableRouter?
    var view: ItemListView?
    
    internal var sections: [SectionTable] = []
    
    func reloadSections(newSections: [SectionTable]) {
        self.sections = newSections
        self.view?.update()
    }
    
    func getNumberOfSections() -> Int {
        print("number of sections: \(sections.count)")
        return sections.count
    }
    
    func getNumberOfRows(sectionNumber: Int) -> Int {
        if getNumberOfSections() == 0 {
            return 0
        }
        return sections[sectionNumber].entities.count
    }
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity {
        let section = indexPath.section
        let row = indexPath.row
        return sections[section].entities[row]
    }
    
    func touchedCellAt(indexPath: IndexPath) {
        router?.navigateToDetailScreen(using: sections[indexPath.section].entities[indexPath.row])
    }
    
    func refreshTableContent() {
        iteractor?.refreshData()
    }
    
    func getNextPage() async {
        
    }

    func titleForSection(section: Int) -> String {
        if sections.count > section {
            return sections[section].name
        }
        return ""
    }
    
    init(iteractor: InteractorMovie? = nil, router: TableRouter? = nil, view: ItemListView? = nil) {
        self.iteractor = iteractor
        self.router = router
        self.view = view
        self.sections = []
    }
}
