//
//  LocationManager.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/08.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import RxSwift
import RxCocoa
import NMapsMap

protocol LocationManager: class {
    
    var authorizationStatus: CLAuthorizationStatus { get }
    
    var authorizationChangingHandler: ((CLAuthorizationStatus) -> Void)? { get }
    
    // var locationUpdatingHandler: ((CLLocation) -> Void)? { get }
    
    var errorHandler: ((Error) -> Void)? { get }
    
    func requestAuthorization()
    
    func startUpdatingLocation()
    
    func stopUpdatingLocation()
    
    // location이 없데이트 되면 호출될 메서드
    func didUpdateLocations() -> Observable<Result<NMGLatLng, GPSError>>
    // mapView를 long Press 할때 호출될 메서드
    // func responseLongPressMap() -> Observable<Result<NMGLatLng, GPSError>>
    
}
