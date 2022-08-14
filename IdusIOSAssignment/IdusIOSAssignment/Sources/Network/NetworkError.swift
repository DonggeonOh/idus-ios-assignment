//
//  NetworkError.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

enum NetworkError: Error {
    case responseError(error: Error)
    case statusCodeError(response: HTTPURLResponse)
    case invalidResponseError
    case invalidDataError
}
