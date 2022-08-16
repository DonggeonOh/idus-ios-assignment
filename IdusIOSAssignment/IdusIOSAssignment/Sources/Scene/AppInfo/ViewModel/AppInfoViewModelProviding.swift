//
//  AppInfoViewModelProviding.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/15.
//

import Foundation

protocol AppInfoViewModelProviding {
    var appInfo: AppInfoModelProviding { get }
    var appTitle: Observable<AppTitleViewModelProviding?> { get }
    var screenImages: Observable<ScreenImageViewModelProviding?> { get }
    var description: Observable<DescriptionViewModelProviding?> { get }
    
    func fetchScreenImages(_ completion: (() -> Void)?)
    func fetchAppTitle(_ completion: (() -> Void)?)
    func fetchDescription(_ completion: (() -> Void)?)
}
