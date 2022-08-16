//
//  SearchViewController.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/11.
//

import UIKit

final class SearchViewController: UIViewController {
    private var viewModel: SearchViewModelProviding?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureViewModel()
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
    
    private func configureViewModel() {
        viewModel = SearchViewModel()
        
        viewModel?.appInfoModel.bind { [weak self] appInfo in
            DispatchQueue.main.async {
                let appInfoViewController = AppInfoViewController()
                
                appInfoViewController.receive(data: appInfo)
                
                self?.navigationController?.pushViewController(appInfoViewController, animated: true)
            }
        }
        
        viewModel?.errorModel.bind { [weak self] errorModel in
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
        
        self.present(alertController, animated: true)
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
