//
//  AppResponse.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

struct AppResponse: Codable {
    let resultCount: Int
    let results: [AppDetail]
}
