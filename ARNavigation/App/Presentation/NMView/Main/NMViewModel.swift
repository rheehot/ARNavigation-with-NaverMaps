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
    let curLocation: Driver<NMGLatLng>
    
    init(model: NMModel = NMModel()) {
        let latlngResult = model.getCurrentLocation().flatMap({ (result) -> ObservableConvertibleType in
            <#code#>
        })
            .asObservable()
        
        self.curLocation = latlngResult.asDriver(onErrorJustReturn: .)
        print(latlngResult)
    }
    
}



