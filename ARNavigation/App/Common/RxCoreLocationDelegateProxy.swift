//
//  RxCoreLocationDelegateProxy.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/03.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import RxCocoa
import RxSwift
import NMapsMap


class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
    static func registerKnownImplementations() {
        self.register { (manager) -> RxCLLocationManagerDelegateProxy in
            RxCLLocationManagerDelegateProxy(parentObject: manager, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: CLLocationManager) -> CLLocationManagerDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: CLLocationManagerDelegate?, to object: CLLocationManager) {
        object.delegate = delegate
        object.startUpdatingLocation()
    }
}

extension Reactive where Base: CLLocationManager {
    var delegateCLLocationManager: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxCLLocationManagerDelegateProxy.proxy(for: self.base)
    }
    
    var didUpdateLocations: Observable<NMGLatLng> {
        return delegateCLLocationManager.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map {
                guard let curLocation = $0[1] as? [CLLocation] else { return NMGLatLng(lat: 0, lng: 0) }
                let coordinate = curLocation[0].coordinate
                return NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
        }
    }
    
}
