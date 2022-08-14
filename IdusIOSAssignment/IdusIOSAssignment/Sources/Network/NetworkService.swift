//
//  NetworkService.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

struct NetworkService: NetworkServicing {
    private typealias Response = (data: Data?, urlResponse: URLResponse?, error: Error?)
    
    private let queue: DispatchQueue
    private let session: URLSession
    private let errorStatusCodeRange = 400..<600
    
    init(session: URLSession = URLSession.shared, queue: DispatchQueue = .global()) {
        self.session = session
        self.queue = queue
    }
    
    func request(
        with url: URL,
        _ completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: url) { data, response, error in
            responseCompletionHandler(Response(data, response, error), completion)
        }
        resume(task: task)
    }
    
    func request(
        with request: URLRequest,
        _ completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            responseCompletionHandler(Response(data, response, error), completion)
        }
        resume(task: task)
    }
    
    private func resume(task: URLSessionDataTask) {
        queue.async {
            task.resume()
        }
    }
    
    private func responseCompletionHandler(
        _ response: Response,
        _ completion: (Result<Data, NetworkError>) -> Void
    ) {
        if let error = response.error {
            completion(.failure(.responseError(error: error)))
            return
        }
        
        if !isValidURLResponse(response.urlResponse, completion) {
            return
        }
        
        guard let data = response.data else {
            completion(.failure(.invalidDataError))
            return
        }
        
        completion(.success(data))
    }
    
    private func isValidURLResponse(
        _ response: URLResponse?,
        _ completion: (Result<Data, NetworkError>) -> Void
    ) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(.invalidResponseError))
            return false
        }
        
        if errorStatusCodeRange ~= httpResponse.statusCode {
            completion(.failure(.statusCodeError(response: httpResponse)))
            return false
        }
        
        return true
    }
}
