//
//  DetailsView.swift
//  ViperMovie
//
//  Created by Gabriel Medeiros Martins on 20/03/24.
//

import Foundation
import UIKit

class DetailsView: UIViewController, ViewWithTable, UITableViewDelegate, UITableViewDataSource {
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
        table.separatorStyle = .none
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        setupConstraints()
        setupNavigationTop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.update()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.goBackToListView()
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
    
    func setupNavigationTop() {
        self.navigationItem.title = "Details"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func update() {
        DispatchQueue.main.async { [weak self] in
            self?.tableview.reloadData()
        }
    }
}

extension DetailsView {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath.section == 0 { // Represents the header cell
            cell = DetailsHeaderViewCell(entity: entity!, style: .default, reuseIdentifier: DetailsHeaderViewCell.identifier)
        } else {
            cell = OverviewTableViewCell(entity: entity!, style: .default, reuseIdentifier: OverviewTableViewCell.identifier)
        }
        
        return cell
    }
}
