//
//  NetworkManaging.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

protocol NetworkManaging {
    func request<T: Decodable>(
        with url: URL,
        decodeTo: T.Type,
        _ completion: @escaping (Result<T, Error>) -> Void
    )
    func request<T: Decodable>(
        with urlRequest: URLRequest,
        decodeTo: T.Type,
        _ completion: @escaping (Result<T, Error>) -> Void
    )
}
