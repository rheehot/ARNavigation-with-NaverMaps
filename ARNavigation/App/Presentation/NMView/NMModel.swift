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
    let locationManager: LocationManager
    
    init(locationManager: LocationManager = LocationManagerImpl()) {
        // locationManager
        self.locationManager = locationManager
        self.locationManager.requestAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> Observable<Result<NMGLatLng, GPSError>> {
        return locationManager.didUpdateLocations()
    }
    
    func parseData(value: NMGLatLng) -> NMGLatLng? {
        return NMGLatLng(lat: value.lat, lng: value.lng)
    }
}
