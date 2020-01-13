//
//  NMViewModel.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import NMapsMap
import RxSwift
import RxCocoa
import RxOptional

protocol NMViewBindable {
    
}

class NMViewModel: NMViewBindable {
    // 현재위치가 변경되면 담을 NMGLatLng 경위도 좌표
    // let changedCurLocation PublishSubject<NMGLatLng>
    // let didTappedMap: Driver<Void>
    let locationData: Signal<NMGLatLng>
    
    init(model: NMModel = NMModel()) {
        print("ViewModel Init")
        let locationResult = model.getCurrentLocation()
            .asObservable()
            .share()
        
        let locationValue = locationResult
            .map { result -> NMGLatLng? in
                guard case .success(let value) = result else { return NMGLatLng(lat: 0, lng: 0) }
                return value
        }
        .filterNil()
        
        self.locationData = locationValue
            .map(model.parseData)
            .filterNil().asSignal(onErrorSignalWith: .empty())
        print("ViewModel", locationData)
    }
    
}



