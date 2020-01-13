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
    }
}

extension Reactive where Base: CLLocationManager {
    var delegateCLLocationManager: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxCLLocationManagerDelegateProxy.proxy(for: self.base)
    }
    
    var didUpdateLocations: Observable<Result<NMGLatLng, GPSError>> {
        return delegateCLLocationManager.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map {
                guard let curLocation = $0[1] as? [CLLocation] else {
                    print("getCurrentLocation 실패")
                    return .failure(GPSError.coreLocationError)
                }
                let coordinate = curLocation[0].coordinate
                
                return .success(NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
        }
    }
    
    var didChangeAuthorization: Observable<CLAuthorizationStatus> {
        return delegateCLLocationManager.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didChangeAuthorization:)))
            .map {
                return  $0[1] as? CLAuthorizationStatus ?? CLAuthorizationStatus.notDetermined
        }
    }
    
    var didFailWithErorr: Observable<Error> {
        return delegateCLLocationManager.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didFailWithError:)))
            .map {
                // TODO: 강제 추출 했음 .. 바인딩 해서 바꿔야함
                return ($0[1] as? Error)!
        }
    }
    
}


