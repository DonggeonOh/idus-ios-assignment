//
//  AppInfoViewController.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/15.
//

import UIKit

final class AppInfoViewController: UIViewController {
    private var scrollView: UIScrollView?
    private var stackView: UIStackView?
    private var appTitleView: AppTitleView?
    private var screenImageView: ScreenImageScrollView?
    private var descriptionView: DescriptionView?
    
    private var viewModel: AppInfoViewModelProviding?
    
    private let stackViewSpacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func receive(data appInfo: AppInfoModelProviding?) {
        guard let appInfo = appInfo else {
            return
        }
        viewModel = AppInfoViewModel(appInfo: appInfo)
    }
    
    private func configureViewController() {
        self.view.backgroundColor = .systemBackground
    }
    
    private func configureViews() {
        configureScrollView()
        configureStackView()
        configureAppTitleView()
        configureScreenImageView()
        configureDescriptionView()
    }
    
    private func configureScrollView() {
        let scrollView = UIScrollView()
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        self.view.addConstraints(scrollViewConstraints)
        
        self.scrollView = scrollView
    }
    
    private func configureStackView() {
        guard let scrollView = scrollView else {
            return
        }
        let stackView = UIStackView()
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor)
        ]
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        scrollView.addConstraints(stackViewConstraints)
        
        stackView.axis = .vertical
        stackView.spacing = stackViewSpacing
        
        self.stackView = stackView
    }
    
    private func configureAppTitleView() {
        let appTitleView = AppTitleView()
        
        stackView?.addArrangedSubview(appTitleView)
        self.appTitleView = appTitleView
        
        viewModel?.appTitle.bind { model in
            guard let model = model else {
                return
            }
            DispatchQueue.main.async {
                appTitleView.update(model: model)
            }
        }
        viewModel?.fetchAppTitle(nil)
    }
    
    private func configureScreenImageView() {
        let screenImageView = ScreenImageScrollView()
        
        stackView?.addArrangedSubview(screenImageView)
        self.screenImageView = screenImageView
        
        viewModel?.screenImages.bind { model in
            guard let model = model else {
                return
            }
            DispatchQueue.main.async {
                screenImageView.update(model: model)
            }
        }
        viewModel?.fetchScreenImages(nil)
    }
    
    private func configureDescriptionView() {
        let descriptionView = DescriptionView()
        
        stackView?.addArrangedSubview(descriptionView)
        self.descriptionView = descriptionView
        
        viewModel?.description.bind { model in
            guard let model = model else {
                return
            }
            DispatchQueue.main.async {
                descriptionView.update(model: model)
            }
        }
        viewModel?.fetchDescription(nil)
    }
}
