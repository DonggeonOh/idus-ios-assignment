//
//  NetworkManager.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

struct NetworkManager: NetworkManaging {
    private let service: NetworkServicing
    
    init(service: NetworkServicing = NetworkService()) {
        self.service = service
    }
    
    func request(
        with url: URL,
        _ completion: @escaping (Result<Data, Error>) -> Void
    ) {
        service.request(with: url) { result in
            responseDataCompletionHandler(result, completion)
        }
    }
    
    func request(
        with urlRequest: URLRequest,
        _ completion: @escaping (Result<Data, Error>) -> Void
    ) {
        service.request(with: urlRequest) { result in
            responseDataCompletionHandler(result, completion)
        }
    }
    
    func request<T: Decodable>(
        with url: URL,
        decodeTo type: T.Type,
        _ completion: @escaping (Result<T, Error>) -> Void
    ) {
        service.request(with: url) { result in
            responseCompletionHandler(result, type, completion)
        }
    }
    
    func request<T: Decodable>(
        with urlRequest: URLRequest,
        decodeTo type: T.Type,
        _ completion: @escaping (Result<T, Error>) -> Void
    ) {
        service.request(with: urlRequest) { result in
            responseCompletionHandler(result, type, completion)
        }
    }
    
    private func responseCompletionHandler<T: Decodable>(
        _ response: Result<Data, NetworkError>,
        _ type: T.Type,
        _ completion: (Result<T, Error>) -> Void
    ) {
        switch response {
        case .success(let data):
            completion(parseResponseData(data, parsedBy: type))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func responseDataCompletionHandler(
        _ response: Result<Data, NetworkError>,
        _ completion: (Result<Data, Error>) -> Void
    ) {
        switch response {
        case .success(let data):
            completion(.success(data))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func parseResponseData<T: Decodable>(
        _ data: Data,
        parsedBy type: T.Type
    ) -> Result<T, Error> {
        do {
            let parsedData = try JSONDecoder().decode(type, from: data)
            return .success(parsedData)
        } catch {
            return .failure(error)
        }
    }
}
