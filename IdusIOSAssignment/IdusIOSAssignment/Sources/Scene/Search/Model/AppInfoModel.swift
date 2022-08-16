//
//  AppInfoModel.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/12.
//

import Foundation

struct AppInfoModel: AppInfoModelProviding {
    let id: String
    let name: String
    let screenshotImageURLs: [String]
    let iconImageURL: String
    let developerName: String
    let genres: [String]
    let appFileSize: String
    let description: String
    
    init(info: AppInfo) {
        self.id = String(info.trackId)
        self.name = info.trackName
        self.screenshotImageURLs = info.screenshotUrls
        self.iconImageURL = info.artworkUrl100
        self.developerName = info.artistName
        self.genres = info.genres
        self.appFileSize = info.fileSizeBytes
        self.description = info.description
    }
}
