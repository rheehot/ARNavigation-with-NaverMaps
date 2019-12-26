//
//  NMAPIService.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol NMAPIServiceType {
    func requestDirivingAPI(navigationData: NavigationData) -> Observable<Driving>
}

final class DrivingAPIService: NMAPIServiceType {
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func requestDirivingAPI(navigationData: NavigationData) -> Observable<Driving> {
        let start = navigationData.startLocation.convertString
        let goal = navigationData.goalLocation.convertString
        
    }
}
