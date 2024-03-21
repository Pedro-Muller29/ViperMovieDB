//
//  DetailsView.swift
//  ViperMovie
//
//  Created by Gabriel Medeiros Martins on 20/03/24.
//

import Foundation
import UIKit

class DetailsView: UIViewController, TableView, UITableViewDelegate, UITableViewDataSource {
    var presenter: (any TablePresenterProtocol)?
    
    private let tableview: UITableView = {
        let table = UITableView()
        
        table.backgroundColor = .systemBackground
        table.allowsSelection = false
        table.register(DetailsHeaderViewCell.self, forCellReuseIdentifier: DetailsHeaderViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getNumberOfRows(sectionNumber: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailsHeaderViewCell.identifier, for: indexPath) as? DetailsHeaderViewCell {
            
        }
        
        // if let cell = overview
        
        
        return UITableViewCell()
    }
    
    func update() {}
}
