//
//  SearchViewModel.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/12.
//

import Foundation

final class SearchViewModel: SearchViewModelProviding {
    private let networkManager: NetworkManaging
    
    let appInfoModel: Observable<AppInfoModelProviding?>
    let errorModel: Observable<AppInfoErrorModelProviding?>
    
    init(
        networkManager: NetworkManaging = NetworkManager(),
        appInfo: AppInfoModelProviding? = nil,
        errorModel: AppInfoErrorModelProviding? = nil
    ) {
        self.networkManager = networkManager
        self.appInfoModel = Observable(appInfo)
        self.errorModel = Observable(errorModel)
    }
    
    func fetch(apiNumber: String, _ completion: (() -> Void)? = nil) {
        guard let url = createURL(apiNumber: apiNumber) else {
            return
        }
        
        networkManager.request(with: url, decodeTo: AppInfoResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                guard let appInfo = response.appInfo.first else {
                    let errorModel = AppInfoErrorModel(description: LocalString.notExistSearchData)
                    self?.errorModel.setValue(errorModel)
                    
                    break
                }
                self?.appInfoModel.setValue(AppInfoModel(info: appInfo))
                
            case.failure (let error):
                let errorModel = AppInfoErrorModel(description: LocalString.notExistSearchData)
                self?.errorModel.setValue(errorModel)
                
                print(error.localizedDescription)
            }
            completion?()
        }
    }
    
    private func createURL(apiNumber: String) -> URL? {
        var urlComponents = URLComponents(string: Const.Network.baseURL)
        urlComponents?.queryItems = [URLQueryItem(name: Const.Network.appIDParameter, value: apiNumber)]
        
        var url = urlComponents?.url
        url?.appendPathComponent(Const.Network.lookupPath)
        
        return url
    }
}
