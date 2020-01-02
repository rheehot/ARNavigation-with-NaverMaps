//
//  RxNaverMapsDelegateProxy.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/02.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import RxSwift
import RxCocoa
import NMapsMap

class RxNMFMapViewDelegateProxy: DelegateProxy<NMFNaverMapView, NMFMapViewDelegate>, DelegateProxyType, NMFMapViewDelegate {
    static func registerKnownImplementations() {
        self.register { (naverMapView) -> RxNMFMapViewDelegateProxy in
            RxNMFMapViewDelegateProxy(parentObject: naverMapView, delegateProxy: self)
        }
    }
    // 현재 obeject 즉 NMFNaverMapView의 delegate 객체 반환
    static func currentDelegate(for object: NMFNaverMapView) -> NMFMapViewDelegate? {
        return object.delegate
    }
    // delegate 객체 설정 -> NMFNaverMapView.delegate = self 와 같은 역할
    static func setCurrentDelegate(_ delegate: NMFMapViewDelegate?, to object: NMFNaverMapView) {
        object.delegate = delegate
    }
}


class RxNMFLocationManagerDelegateProxy: DelegateProxy<NMFLocationManager, NMFLocationManagerDelegate>, DelegateProxyType, NMFLocationManagerDelegate {
    static func registerKnownImplementations() {
        self.register{ (locationManager) -> RxNMFLocationManagerDelegateProxy in
            RxNMFLocationManagerDelegateProxy(parentObject: locationManager, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: NMFLocationManager) -> NMFLocationManagerDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: NMFLocationManagerDelegate?, to object: NMFLocationManager) {
        object.add(delegate)
    }
    
}

extension NMFLocationManager {
    var delegate: NMFLocationManagerDelegate {
        return  NMFLocationManager.sharedInstance()!.delegate
    }
}


extension Reactive where Base: NMFNaverMapView {
    var delegate: DelegateProxy<NMFNaverMapView, NMFMapViewDelegate> {
        return RxNMFMapViewDelegateProxy.proxy(for: self.base)
    }
    
    var didTapMapView: Observable<NMGLatLng> {
        // 처음 map -> parameter 컬렉션 반환 -> parameter[1] == latlng: NMGLatLng임
        return delegate.methodInvoked(#selector(NMFMapViewDelegate.didTapMapView(_:latLng:)))
            .map {
                return ($0[1] as? NMGLatLng ?? NMGLatLng())
        }
    }
    
    var currentLocationChange: Observable<[Any]> {
        return delegate.methodInvoked(#selector(NMFLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map{
                return $0[1] as? [Any] ?? []
        }
    }
}
