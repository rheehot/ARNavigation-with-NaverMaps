//
//  LocationManagerImpl.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/08.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import RxSwift
import RxCocoa
import NMapsMap


class LocationManagerImpl: NSObject {
    
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        return manager
    }()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
}

extension LocationManagerImpl: LocationManager {
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    var authorizationChangingHandler: ((CLAuthorizationStatus) -> Void)? {
        return { status in
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                self.startUpdatingLocation()
            default:
                NotificationCenter.default
                    .post(name: .locationPermissionDenied, object: nil, userInfo: ["status": status])
            }
        }
    }
    
//    var locationUpdatingHandler: ((CLLocation) -> Void)? {
//        // 위치 정보 갱신
//    }
    
    var errorHandler: ((Error) -> Void)? {
        return { error in
            guard error is CLError else { return }
            NotificationCenter.default
                .post(name: .didFailUpdatingAllLocationTasks,
                      object: nil,
                      userInfo: ["error": GPSError.coreLocationError])
        }
    }
    
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func didUpdateLocations() -> Observable<Result<NMGLatLng, GPSError>> {
        return locationManager.rx.didUpdateLocations
    }
    
}


extension LocationManagerImpl: CLLocationManagerDelegate {

}
