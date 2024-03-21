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
    
    var entity: Entity? {
        didSet {
            self.update()
        }
    }
    
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
        
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func update() {
        tableview.reloadData()
    }
}

extension DetailsView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsHeaderViewCell.identifier, for: indexPath) as? DetailsHeaderViewCell,
//              let entity = entity else { return UITableViewCell() }
        let cell = DetailsHeaderViewCell(entity: entity!, style: .default, reuseIdentifier: DetailsHeaderViewCell.identifier)
        
//        cell.entity = entity
//        cell.updateData()
        
        return cell
    }
}
