//
//  SearchViewController.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/11.
//

import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureTableView()
    }
    
    func configureViewController() {
        self.view.backgroundColor = .systemBackground
    }
    
    func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.title = "검색"
    }
    
    // TODO: Table view cell identifier 코드 추가
    func configureTableView() {
        let tableView = UITableView()
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableViewConstraints = [tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                    tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)]
        
        self.view.addConstraints(tableViewConstraints)
    }
}
