//
//  ViewController.swift
//  MovieDBViper
//
//  Created by Pedro Mezacasa Muller on 18/03/24.
//

import UIKit
import NetworkService
import Combine

class ItemListView: UIViewController, TableView {
    
    // MARK: Presenter reference
    var presenter: (any TablePresenterProtocol)?
    var tableViewRefresh = UIRefreshControl()
    var searchTask: DispatchWorkItem?

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
        tableView.refreshControl = tableViewRefresh
        
        tableViewRefresh.addTarget(self, action:#selector(refreshTableContent), for: .valueChanged)
        self.setupUI()
        presenter?.refreshTableContent()
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshTableContent() {
        presenter?.refreshTableContent()
        tableViewRefresh.endRefreshing()
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
        let search = UISearchController()
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
    }
    
    // MARK: Updating
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: Table View Delegate
extension ItemListView: UITableViewDelegate, UITableViewDataSource {
   

    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.getNumberOfSections() ?? 0
    }
    
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = presenter?.titleForSection(section: section)
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        let header: UITableViewHeaderFooterView = UITableViewHeaderFooterView()
        header.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: header.centerYAnchor)
        ])
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.touchedCellAt(indexPath: indexPath)
    }
    

}

// TODO: CHAMAR AQUI OS SEARCHS
// MARK: Serch Controller Delegate
extension ItemListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         guard let searchText = searchBar.text else { return }
        
        self.searchTask?.cancel()

        let task = DispatchWorkItem { [weak self] in
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
              print(searchText)
              DispatchQueue.main.async {
                  // TODO: PARA A CHAMADA
                  //Update UI
              }
            }
          }
        
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: task)

    }
}
