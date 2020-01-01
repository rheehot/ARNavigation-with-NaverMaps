//
//  ObservableType+Extension.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/01.
//  Copyright © 2020 youngjun goo. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    var value: Wrapped? {
        return self
    }
}

extension Observable where Element: OptionalType {
    
    func filterNil() -> Observable<Element.Wrapped> {
        return flatMap { (element) -> Observable<Element.Wrapped> in
            if let value = element.value {
                return .just(value)
            } else {
                return .empty()
            }
        }
    }
}

extension ObservableType {
    func filterNilValue<Value>(_ transform: @escaping (E) -> Value?) -> Observable<Value> {
        return map(transform).filterNil()
    }
}
