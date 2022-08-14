//
//  String+Extension.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/13.
//

import Foundation

extension String {
    static var empty: String {
        return ""
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: .empty)
    }
    
    func localized(_ string: String, comment: String) -> String {
        return NSLocalizedString(string, comment: comment)
    }
}
