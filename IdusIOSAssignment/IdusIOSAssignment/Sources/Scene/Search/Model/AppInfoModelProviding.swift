//
//  AppInfoModelProviding.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

protocol AppInfoModelProviding {
    var id: String { get }
    var name: String { get }
    var screenshotImageURLs: [String] { get }
    var iconImageURL: String { get }
    var developerName: String { get }
    var genres: [String] { get }
    var appFileSize: String { get }
    var description: String { get }
}
