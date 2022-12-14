//
//  AppInfoViewModel.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/15.
//

import Foundation

final class AppInfoViewModel: AppInfoViewModelProviding {
    private let manager: NetworkManager
    private let appInfo: AppInfoModelProviding
    
    let appTitle: Observable<AppTitleViewModelProviding?>
    let screenImages: Observable<ScreenImageViewModelProviding?>
    let description: Observable<DescriptionViewModelProviding?>
    let appInformations: Observable<[AppInformationViewModelProviding]?>
    
    private var tempScreenImageData: [Data]
    
    init(
        manager: NetworkManager = NetworkManager(),
        appInfo: AppInfoModelProviding,
        appTitle: AppTitleViewModelProviding? = nil,
        screenImages: ScreenImageViewModelProviding? = nil,
        description: DescriptionViewModelProviding? = nil,
        appInformations: [AppInformationViewModelProviding]? = nil
    ) {
        self.manager = manager
        self.appInfo = appInfo
        self.appTitle = Observable(appTitle)
        self.screenImages = Observable(screenImages)
        self.description = Observable(description)
        self.appInformations = Observable(appInformations)
        
        self.tempScreenImageData = []
    }
    
    func fetchScreenImages(_ completion: (() -> Void)?) {
        let group = DispatchGroup()
        
        for urlString in appInfo.screenshotImageURLs {
            group.enter()
            
            guard let url = URL(string: urlString) else {
                return
            }
            self.manager.request(with: url) { result in
                switch result {
                case .success(let screenImageData):
                    self.tempScreenImageData.append(screenImageData)
                    completion?()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completion?()
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.screenImages.setValue(ScreenImageModel(screenImages: self.tempScreenImageData))
        }
    }
    
    func fetchAppTitle(_ completion: (() -> Void)?) {
        guard let url = URL(string: appInfo.iconImageURL) else {
            return
        }
        manager.request(with: url) { result in
            switch result {
            case .success(let iconData):
                let name = self.appInfo.name
                self.appTitle.setValue(AppTitleModel(iconData: iconData, name: name))
                completion?()
                
            case .failure(let error):
                print(error.localizedDescription)
                completion?()
            }
        }
    }
    
    func fetchDescription(_ completion: (() -> Void)?) {
        description.setValue(DescriptionModel(description: appInfo.description))
    }
    
    func fetchAppInformations(_ completion: (() -> Void)?) {
        let fileSize = Byte(bytes: UInt64(appInfo.appFileSize) ?? .zero)
        let appInformationModels = [
            AppInformationModel(title: LocalString.developerName, description: appInfo.developerName),
            AppInformationModel(title: LocalString.fileSize, description: String(fileSize.mb) + "MB"),
            AppInformationModel(title: LocalString.category, description: appInfo.genres.first ?? .empty)
        ]
        appInformations.setValue(appInformationModels)
    }
}
