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
    // input
    // var longPressedMap: ControlEvent<Void> { get }
    // output
    // var pressMapData: Signal<NMGLatLng> { get }
    var locationData: Signal<NMGLatLng> { get }
}

class NMViewModel: NMViewBindable {
    // input
    // let longPressedMap: ControlEvent<Void>
    // output
    // let pressMapData: Signal<NMGLatLng>
    let locationData: Signal<NMGLatLng>
    // 현재위치가 변경되면 담을 NMGLatLng 경위도 좌표
    // let changedCurLocation PublishSubject<NMGLatLng>
    // let didTappedMap: Driver<Void>
    
    init(model: NMModel = NMModel()) {
        let locationResult = model.getCurrentLocation()
            .asObservable()
            .share()
        
        let locationValue = locationResult
            .map { result -> NMGLatLng? in
                guard case .success(let value) = result else { return NMGLatLng(lat: 0, lng: 0) }
                return value
        }
        .filterNil()
        
        locationData = locationValue
            .map(model.parseData)
            .filterNil()
            .asSignal(onErrorSignalWith: .empty())
    }
    
}



