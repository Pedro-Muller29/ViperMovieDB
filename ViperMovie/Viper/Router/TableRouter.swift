//
//  TableRouter.swift
//  ViperMovie
//
//  Created by Filipe Ilunga on 20/03/24.
//

import Foundation

class TableRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = TableRouter()
        let view = ItemListView()
        let presenter  = TablePresenter()
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
    func navigateToDetailScreen(using entity: Entity) {
        let view = DetailsView()
        view.entity = entity
        
        entry?.navigationController?.pushViewController(view, animated: true)
    }

}
