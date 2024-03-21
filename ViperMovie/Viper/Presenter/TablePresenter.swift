//
//  TablePresenter.swift
//  PresenterViperMovieDB
//
//  Created by Joao Paulo Carneiro on 19/03/24.
//

import Foundation
import NetworkService


protocol AnyPresenter {
    associatedtype InteractorProtocol where InteractorProtocol: AnyInteractor
    
    associatedtype RouterProtocol where RouterProtocol: AnyRouter
    
    associatedtype ViewProtocol where ViewProtocol: AnyView
    
    var iteractor: InteractorProtocol? { get set }
    
    var router: RouterProtocol? { get set }
    
    var view: ViewProtocol? { get set }
}

protocol TablePresenterProtocol: AnyPresenter {
    associatedtype EntityType where EntityType: Entity
    var sections: [SectionTable<EntityType>] { get set }
    
    func getNumberOfSections() -> Int
    
    func getNumberOfRows(sectionNumber: Int) -> Int
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity
    
    func touchedCellAt(indexPath: IndexPath)
    
    func getNextPage(sectionIndex: Int)
    
    func refreshTableContent()

}

class TablePresenter<EntityType>: TablePresenterProtocol where EntityType: Entity {
    var iteractor: InteractorMovie?
    var router: Router?
    var view: ItemListView?
    
    var gettingNextPage: Bool = false
    
    internal var sections: [SectionTable<EntityType>] = []
    
    func reloadSections(newSections: [SectionTable<EntityType>]) {
        self.sections = newSections
        self.view?.update()
    }
    
    func getNumberOfSections() -> Int {
        return sections.count
    }
    
    func getNumberOfRows(sectionNumber: Int) -> Int {
        if getNumberOfSections() == 0 {
            return 0
        }
        return sections[sectionNumber].entities.count
    }
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity {
        let sectionIndex = indexPath.section
        let section = sections[sectionIndex]
        let row = indexPath.row
        if row >= (section.entities.count - 5) && !gettingNextPage && sectionIndex == 0 {
            self.getNextPage(sectionIndex: sectionIndex)
        }
        return section.entities[row]
    }
    
    func touchedCellAt(indexPath: IndexPath) {
        
    }
    
    func refreshTableContent() {
        self.iteractor?.refreshData()
    }
    
    func getNextPage(sectionIndex: Int) {
        self.gettingNextPage = true
        let dispatchGroup = DispatchGroup()
        
        sections[sectionIndex].page += 1
        
        dispatchGroup.enter()
        self.iteractor?.getNextPage(page: sections[sectionIndex].page, completion: { itens in
            if let itens = itens as? [EntityType] {
                self.sections[sectionIndex].entities.append(contentsOf: itens)
            }
            
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            self.view?.update()
            print("JORGE \(self.sections[sectionIndex].entities.count), page: \(self.sections[sectionIndex].page)")
            self.gettingNextPage = false
        }
    }
    
    func updateView() {
        self.view?.update()
    }
    
    init(iteractor: InteractorProtocol? = nil, router: RouterProtocol? = nil, view: ViewProtocol? = nil) {
        self.iteractor = iteractor
        self.router = router
        self.view = view
        self.sections = []
        self.refreshTableContent()
    }
}
