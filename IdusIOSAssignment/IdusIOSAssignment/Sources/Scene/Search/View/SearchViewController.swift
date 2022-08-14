//
//  SearchViewController.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/11.
//

import UIKit

final class SearchViewController: UIViewController {
    private var tableView: UITableView?
    
    private var viewModel: SearchViewModelProviding?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureTableView()
        configureViewModel()
    }
    
    private func configureViewModel() {
        viewModel = SearchViewModel()
        
        viewModel?.searchVMData.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }
        
        viewModel?.searchErrorData.bind { [weak self] errorModel in
            DispatchQueue.main.async {
                guard let description = errorModel?.description else {
                    return
                }
                self?.presentAlertController(title: description)
            }
        }
    }
    
    private func presentAlertController(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let confirmAlertAction = UIAlertAction(title: LocalString.confirm, style: .default, handler: nil)
        
        alertController.addAction(confirmAlertAction)
        
        present(alertController, animated: true)
    }
    
    private func configureViewController() {
        self.view.backgroundColor = .systemBackground
    }
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsSearchResultsController = true
        
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.title = LocalString.searchTitle
        self.navigationItem.searchController?.searchBar.placeholder = LocalString.searchPlaceHolder
    }
    
    private func configureTableView() {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: Const.identifier.searchTableViewCellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        self.tableView = tableView
        self.view.addSubview(tableView)
        self.view.addConstraints(tableViewConstraints)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        let activityIndicator = createActivityIndicator()
        
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
        
        self.viewModel?.fetch(apiNumber: text) {
            DispatchQueue.main.async {
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        
        self.view.addSubview(activityIndicator)
        
        activityIndicator.center = self.view.center
        activityIndicator.style = .large
        
        return activityIndicator
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.identifier.searchTableViewCellID, for: indexPath)
        
        guard let searchCell = cell as? SearchTableViewCell else {
            return cell
        }
        searchCell.update(cellData: self.viewModel?.value(at: indexPath))
        
        return searchCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
