//
//  TableRouter.swift
//  ViperMovie
//
//  Created by Filipe Ilunga on 20/03/24.
//

import Foundation

protocol TableRouterProtocol: AnyRouter {
    func navigateToDetailScreen(using entity: Entity, current: any TablePresenterProtocol)
    
    func goBackToListView(presenter: any TablePresenterProtocol)
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
    func navigateToDetailScreen(using entity: Entity, current: any TablePresenterProtocol) {
        let view = DetailsView()
        view.entity = entity
        view.presenter = current
        current.view = view
        
        entry?.navigationController?.pushViewController(view, animated: true)
        
    }

    // Só é necessário passar a referencia do presenter de volta para a itemListView
    func goBackToListView(presenter: any TablePresenterProtocol) {
        guard var view = entry?.navigationController?.viewControllers.first as? any ViewWithTable else { return }
        presenter.view = view
    }
}
