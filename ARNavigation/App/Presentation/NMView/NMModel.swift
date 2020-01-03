//
//  NMModel.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/26.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import RxSwift

struct NMModel {
    let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func getDriving(data: NavigationData) -> Observable<Result<Driving, NetworkError>> {
        return apiService.getDriving(data: data)
    }

}
