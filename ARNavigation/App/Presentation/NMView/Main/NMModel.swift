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
        print("Model Init")
        self.locationManager = locationManager
        print(self.locationManager)
        locationManager.requestAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> Observable<Result<NMGLatLng, GPSError>> {
        print("Model getCurrentLocation")
        return locationManager.didUpdateLocations()
    }
    
    func parseData(value: NMGLatLng) -> NMGLatLng? {
        return NMGLatLng(lat: value.lat, lng: value.lng)
    }
}
