//
//  NetworkManager.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol NetworkManagerType {
    func request(_ target: TargetType) -> Observable<Any>
}

final class NetworkManager: NetworkManagerType {
    
    func request(_ target: TargetType) -> Observable<Any> {
        var urlComponents = URLComponents()
        // TODO: url schem, host, path 등 수정 추후

    }
}

