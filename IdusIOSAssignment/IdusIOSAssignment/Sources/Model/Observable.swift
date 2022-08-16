//
//  Observable.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/14.
//

import Foundation

final class Observable<T> {
    private var listener: ((T) -> Void)?
    private(set) var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func setValue(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
    }
}
