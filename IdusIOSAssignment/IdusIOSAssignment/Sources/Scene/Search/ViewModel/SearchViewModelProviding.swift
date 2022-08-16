//
//  SearchViewModelProviding.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/12.
//

import Foundation

protocol SearchViewModelProviding {
    var appInfoModel: Observable<AppInfoModelProviding?> { get }
    var errorModel: Observable<AppInfoErrorModelProviding?> { get }
    
    func fetch(apiNumber: String, _ completion: (() -> Void)?)
}
