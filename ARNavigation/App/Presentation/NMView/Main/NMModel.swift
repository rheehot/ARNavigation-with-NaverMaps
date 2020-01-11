//
//  NMModel.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/26.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import NMapsMap
import RxCocoa
import RxSwift

struct NMModel {
    let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
    }
    
    func getCurrentLocation() -> Observable<Result<NMGLatLng, GPSError>> {
        return locationManager.rx.didUpdateLocations
    }
}
