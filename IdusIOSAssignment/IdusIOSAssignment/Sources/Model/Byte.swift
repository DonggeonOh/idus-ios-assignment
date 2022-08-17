//
//  Byte.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/17.
//

import Foundation

struct Byte {
    let bytes: UInt64
    
    var kb: Double {
        return Double(bytes / 1024)
    }
    
    var mb: Double {
        return kb / 1024
    }
    
    init(bytes: UInt64) {
        self.bytes = bytes
    }
}
