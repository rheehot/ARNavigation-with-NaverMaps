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

extension Reactive where Base: NMFNaverMapView {
    // delegate
    var delegateNMFMapView: DelegateProxy<NMFNaverMapView, NMFMapViewDelegate> {
        return RxNMFMapViewDelegateProxy.proxy(for: self.base)
    }
    // map 터치시 좌표 봔환 콜백
    var didTapMapView: Observable<NMGLatLng> {
        return delegateNMFMapView.methodInvoked(#selector(NMFMapViewDelegate.didTapMapView(_:latLng:)))
            .map {
                return ($0[1] as? NMGLatLng ?? NMGLatLng())
        }
    }
//    // map symbol 터치시 해당 심볼 정보 반환 콜백
//    var didTapSymbol: ControlEvent<NMFSymbol> {
//        let source : Observable<NMFSymbol> = delegateNMFMapView.methodInvoked(#selector(NMFMapViewDelegate.mapView(_:didTap:)))
//        .map(<#T##transform: ([Any]) throws -> Result##([Any]) throws -> Result#>)
//    }
//    
    var regionDidChangeAnimated: Observable<Bool> {
        return delegateNMFMapView.methodInvoked(#selector(NMFMapViewDelegate.mapView(_:regionDidChangeAnimated:byReason:)))
            .map {
                return $0[1] as? Bool ?? false
        }
    }
    
}
