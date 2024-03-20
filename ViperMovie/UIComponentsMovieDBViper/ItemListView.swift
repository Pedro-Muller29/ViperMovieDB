//
//  ViewController.swift
//  MovieDBViper
//
//  Created by Pedro Mezacasa Muller on 18/03/24.
//

import UIKit

class ItemListView: UIViewController, AnyView {
    
    // MARK: Presenter reference
    var presenter: TablePresenter?
    
    // MARK: UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(ImageTitleDescriptionRatingTableViewCell.self, forCellReuseIdentifier: ImageTitleDescriptionRatingTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.setupUI()
        // Do any additional setup after loading the view.
    }

    // MARK: Setup UIS
    func setupUI() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Movies"
        self.navigationItem.searchController = UISearchController()
    }
    
    // MARK: Updating
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ItemListView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getNumberOfRows(sectionNumber: section) ?? 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTitleDescriptionRatingTableViewCell.identifier, for: indexPath)
                as? ImageTitleDescriptionRatingTableViewCell else { return UITableViewCell() }
//        cell.data = presenter?.getDataForCell(identifier: ImageTitleDescriptionRatingTableViewCell.identifier, indexPath: indexPath)
        if let entity = presenter?.getDataForCell(identifier: ImageTitleDescriptionRatingTableViewCell.identifier, indexPath: indexPath) {
            cell.updateUI(with: entity)
        }
        return cell
    }
    
    
}

