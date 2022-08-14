//
//  SearchModel.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/12.
//

import Foundation

struct SearchModel: SearchViewModelData {
    let id: String
    let name: String
    
    init(data: AppDetail) {
        self.id = String(data.trackId)
        self.name = data.trackName
    }
}
