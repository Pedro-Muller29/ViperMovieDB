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
    
    associatedtype RouterProtocol = any AnyRouter
    
    associatedtype ViewProtocol = any AnyView
    
    var iteractor: InteractorProtocol? { get set }
    
    var router: RouterProtocol? { get set }
    
    var view: ViewProtocol? { get set }
}

protocol TablePresenterProtocol: AnyPresenter where RouterProtocol == any TableRouterProtocol, ViewProtocol == any ViewWithTable {
    associatedtype EntityType where EntityType: Entity
    
    var sections: [SectionTable<EntityType>] { get set }
    
    func getNumberOfSections() -> Int
    
    func getNumberOfRows(sectionNumber: Int) -> Int
    
    func titleForSection(section: Int) -> String
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity
    
    func touchedCellAt(indexPath: IndexPath)
    
    func getNextPage(sectionIndex: Int)
    
    func refreshTableContent()
    
    func goBackToListView()
}

class TablePresenter<EntityType>: TablePresenterProtocol where EntityType: Entity {
    
    var iteractor: InteractorMovie?
    var router: TableRouterProtocol?
    var view: (any ViewWithTable)?
    
    var gettingNextPage: Bool = false
    
    internal var sections: [SectionTable<EntityType>] = []
    
    func reloadSections(newSections: [SectionTable<EntityType>]) {
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
        let sectionIndex = indexPath.section
        let section = sections[sectionIndex]
        let row = indexPath.row
        if row >= (section.entities.count - 5) && !gettingNextPage && sectionIndex == 0 {
            self.getNextPage(sectionIndex: sectionIndex)
        }
        return section.entities[row]
    }
    
    func touchedCellAt(indexPath: IndexPath){
        router?.navigateToDetailScreen(using: sections[indexPath.section].entities[indexPath.row], current: self)
    }
    
    func refreshTableContent() {
        iteractor?.refreshData()
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

    func titleForSection(section: Int) -> String {
        if sections.count > section {
            return sections[section].name
        }
        return ""
    }
    
    func goBackToListView() {
        router?.goBackToListView(presenter: self)
    }
    
    init(iteractor: InteractorMovie? = nil, router: TableRouter? = nil, view: ItemListView? = nil) {
        self.iteractor = iteractor
        self.router = router
        self.view = view
        self.sections = []
    }
}
