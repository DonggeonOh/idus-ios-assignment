//
//  AppDetail.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

struct AppDetail: Codable {
    let screenshotUrls: [String]
    let ipadScreenshotUrls: [String]
    let appletvScreenshotUrls: [String]
    let artworkUrl60: String
    let artworkUrl512: String
    let artworkUrl100: String
    let artistViewUrl: String
    let features: [String]
    let advisories: [String]
    let isGameCenterEnabled: Bool
    let supportedDevices: [String]
    let kind: String
    let minimumOsVersion: String
    let trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let formattedPrice: String
    let contentAdvisoryRating: String
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewUrl: String
    let trackContentRating: String
    let currentVersionReleaseDate: String // Date
    let releaseNotes: String
    let description: String
    let currency: String
    let sellerName: String
    let bundleId: String
    let genreIds: [String]
    let releaseDate: String // Date
    let primaryGenreName: String
    let primaryGenreId: Int
    let trackId: Int
    let trackName: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let artistId: Int
    let artistName: String
    let genres: [String]
    let price: Double
    let version: String
    let wrapperType: String
    let userRatingCount: Int
}
