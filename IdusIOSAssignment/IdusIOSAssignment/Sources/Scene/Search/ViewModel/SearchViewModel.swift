//
//  SearchViewModel.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/12.
//

import Foundation

final class SearchViewModel: SearchViewModelProviding {
    private let networkManager: NetworkManaging
    
    let searchVMData: Observable<[SearchViewModelData]>
    let searchErrorData: Observable<SearchErrorViewModelData?>
    
    var count: Int {
        return searchVMData.value.count
    }
    
    init(model: [SearchViewModelData] = [], networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
        self.searchVMData = Observable(model)
        self.searchErrorData = Observable(nil)
    }
    
    func fetch(apiNumber: String, _ completion: (() -> Void)? = nil) {
        guard let url = createURL(apiNumber: apiNumber) else {
            return
        }
        
        networkManager.request(with: url, decodeTo: AppResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                guard response.resultCount != .zero else {
                    let errorModel = SearchErrorModel(description: LocalString.notExistSearchData)
                    self?.searchErrorData.setValue(errorModel)
                    break
                }
                self?.searchVMData.setValue(response.results.map { SearchModel(data: $0) })
                
            case.failure (let error):
                let errorModel = SearchErrorModel(description: LocalString.notExistSearchData)
                self?.searchErrorData.setValue(errorModel)
                print(error.localizedDescription)
            }
            completion?()
        }
    }
    
    func value(at indexPath: IndexPath) -> SearchViewModelData {
        return searchVMData.value[indexPath.item]
    }
        
    private func createURL(apiNumber: String) -> URL? {
        var urlComponents = URLComponents(string: Const.Network.baseURL)
        urlComponents?.queryItems = [URLQueryItem(name: Const.Network.appIDParameter, value: apiNumber)]
        
        var url = urlComponents?.url
        url?.appendPathComponent(Const.Network.lookupPath)
        
        return url
    }
}
