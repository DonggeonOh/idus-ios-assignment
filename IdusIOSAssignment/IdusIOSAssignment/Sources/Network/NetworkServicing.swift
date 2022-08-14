//
//  NetworkServicing.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

protocol NetworkServicing {
    func request(
        with url: URL,
        _ completion: @escaping (Result<Data, NetworkError>) -> Void
    )
    func request(
        with url: URLRequest,
        _ completion: @escaping (Result<Data, NetworkError>) -> Void
    )
}
