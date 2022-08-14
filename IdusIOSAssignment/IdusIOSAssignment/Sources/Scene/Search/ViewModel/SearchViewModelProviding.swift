//
//  SearchViewModelProviding.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/12.
//

import Foundation

protocol SearchViewModelProviding {
    var count: Int { get }
    var searchVMData: Observable<[SearchViewModelData]> { get }
    var searchErrorData: Observable<SearchErrorViewModelData?> { get }
    
    func fetch(apiNumber: String, _ completion: (() -> Void)?)
    func value(at indexPath: IndexPath) -> SearchViewModelData
}
