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

protocol TablePresenterProtocol: AnyPresenter where RouterProtocol == any TableRouterProtocol {
    associatedtype EntityType where EntityType: Entity
    
    var sections: [SectionTable<EntityType>] { get set }
    
    var search: String { get set }
    
    var searchResult: [SectionTable<EntityType>] { get set }
    
    func firstLoad()
    
    func getNumberOfSections() -> Int
    
    func getNumberOfRows(sectionNumber: Int) -> Int
    
    func titleForSection(section: Int) -> String
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity
    
    func touchedCellAt(indexPath: IndexPath)
    
    func updateSearchStringToEmpty()
    
    func goSearchEntity(searchText: String)
    
    func getNextPage(sectionIndex: Int, search: String)
    
    func refreshTableContent()
}

class TablePresenter<EntityType>: TablePresenterProtocol where EntityType: Entity {
    
    var iteractor: InteractorMovie?
    var router: TableRouterProtocol?
    var view: ItemListView?
    
    var search: String = ""
    
    var searchResult: [SectionTable<EntityType>] = []
    
//    var gettingNextPage: Bool = false
    
    internal var sections: [SectionTable<EntityType>] = []
    
    func firstLoad() {
        self.iteractor?.getAllGenreFromRemote {
            DispatchQueue.main.async {
                self.refreshTableContent()
            }
        }
    }
    
    func reloadSections(newSections: [SectionTable<EntityType>]) {
        self.sections = newSections
        self.view?.update()
    }
    
    func getNumberOfSections() -> Int {
        return search.isEmpty ? sections.count : searchResult.count
    }
    
    func getNumberOfRows(sectionNumber: Int) -> Int {
        if getNumberOfSections() == 0 {
            return 0
        }
        return search.isEmpty ? sections[sectionNumber].entities.count : searchResult[sectionNumber].entities.count
    }
    
    func getDataForCell(identifier: String, indexPath: IndexPath) -> Entity {
        if search.isEmpty {
            let sectionIndex = indexPath.section
            let section = sections[sectionIndex]
            let row = indexPath.row
            if row >= (section.entities.count - 5) && sectionIndex != 0 {
                self.getNextPage(sectionIndex: sectionIndex, search: self.search)
            }
            return section.entities[row]
        } else {
            let sectionIndex = indexPath.section
            let section = searchResult[sectionIndex]
            let row = indexPath.row
            if row >= (section.entities.count - 5) && sectionIndex != 0 {
                self.getNextPage(sectionIndex: sectionIndex, search: self.search)
            }
            return section.entities[row]
        }
    }
    
    func touchedCellAt(indexPath: IndexPath) {
        router?.navigateToDetailScreen(using: sections[indexPath.section].entities[indexPath.row])
    }
    
    func refreshTableContent() {
        iteractor?.refreshData()
    }
    
    func updateSearchStringToEmpty() {
        self.search = ""
        self.updateView()
    }
    
    func goSearchEntity(searchText: String) {
        self.search = searchText
        self.searchResult = [ SectionTable(name: "Search", page: 0, entities: []) ]
        self.getNextPage(sectionIndex: 0, search: searchText)
    }
    
    // TODO: CONTINUAR AQUI. PRECISA COLOCAR LOGICA PARA IR FAZER A BUSCA DA PROXIMA PAGINA.
    func getNextPage(sectionIndex: Int, search: String) {
        let dispatchGroup = DispatchGroup()
        if search.isEmpty {
            sections[sectionIndex].page += 1
            dispatchGroup.enter()
            self.iteractor?.getNextPage(page: sections[sectionIndex].page, search: search, completion: { itens in
                if let itens = itens as? [EntityType] {
                    self.sections[sectionIndex].entities.append(contentsOf: itens)
                }
                dispatchGroup.leave()
            })
        } else {
            searchResult[sectionIndex].page += 1
            dispatchGroup.enter()
            self.iteractor?.getNextPage(page: searchResult[sectionIndex].page, search: search, completion: { itens in
                if let itens = itens as? [EntityType] {
                    self.searchResult[sectionIndex].entities.append(contentsOf: itens)
                }
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main) {
            self.view?.update()
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
    
    init(iteractor: InteractorMovie? = nil, router: TableRouter? = nil, view: ItemListView? = nil) {
        self.iteractor = iteractor
        self.router = router
        self.view = view
        self.sections = []
    }
}
