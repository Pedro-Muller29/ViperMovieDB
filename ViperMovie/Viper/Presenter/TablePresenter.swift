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
    var view: ItemListView?
    
    internal var sections: [SectionTable] = []
    
//    lazy var array: [MovieEntity] = {
//        guard let request = MovieDBURLRequestBuilder.movie(category: .popular, page: 1).request else { return [] }
//        NetworkService.fetch(request: request) { (result: Result<[MovieEntity], any Error>) in
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                switch result {
//                case .success(let success):
//                    self.array = success
//                    print(success.count)
//                    self.view?.update()
//                case .failure(let failure):
//                    return
//                }
//            }
//        }
//        return []
//    }()
    
    func reloadSections(newSections: [SectionTable]) {
        print(newSections.count)
        for section in newSections {
            print(section.entities.count)
        }
        self.sections = newSections
        self.view?.update()
        print("deu reload")
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
        let section = indexPath.section
        let row = indexPath.row
        return sections[section].entities[row]
    }
    
    func touchedCellAt(indexPath: IndexPath) {
        
    }
    
    func refreshTableContent() {
        print("refreshhhhhh")
        self.iteractor?.refreshData()
    }
    
    func getNextPage() async {
        
    }
    
    init(iteractor: InteractorProtocol? = nil, router: RouterProtocol? = nil, view: ViewProtocol? = nil) {
        self.iteractor = iteractor
        self.router = router
        self.view = view
        self.sections = []
        self.refreshTableContent()
    }
}
