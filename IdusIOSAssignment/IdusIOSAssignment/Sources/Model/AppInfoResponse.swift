//
//  AppInfoResponse.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

struct AppInfoResponse: Codable {
    let appInfo: [AppInfo]
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case appInfo = "results"
        case count = "resultCount"
    }
}
