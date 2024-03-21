//
//  TableRouter.swift
//  ViperMovie
//
//  Created by Filipe Ilunga on 20/03/24.
//

import Foundation

protocol TableRouterProtocol: AnyRouter {
    func navigateToDetailScreen(viewController: ItemListView?)
}

class TableRouter: TableRouterProtocol {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = TableRouter()
        let view = ItemListView()
        let presenter  = TablePresenter<MovieEntity>()
        let interactor = InteractorMovie()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.iteractor = interactor
        
        router.entry = view as? EntryPoint
        return router
    }
    
    //Passar a viewController na chamada
    func navigateToDetailScreen(viewController: ItemListView? = nil) {
        let view = ItemListView()
        
        entry?.navigationController?.pushViewController(view, animated: false)
    }

}
