//
//  LocationManager.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/08.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManager: class {
    
    var authorizationStatus: CLAuthorizationStatus { get }
    
    var authorizationChangingHandler: ((CLAuthorizationStatus) -> Void)? { get }
    
    // var locationUpdatingHandler: ((CLLocation) -> Void)? { get }
    
    var errorHandler: ((Error) -> Void)? { get }
    
    func requestAuthorization()
    
    func startUpdatingLocation()
    
    func stopUpdatingLocation()
    
}
