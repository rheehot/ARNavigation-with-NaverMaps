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

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}

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
    var didTapMapView: ControlEvent<NMGLatLng> {
        let source: Observable<NMGLatLng> = delegateNMFMapView
            .methodInvoked(#selector(NMFMapViewDelegate.didTapMapView(_:latLng:)))
            .map { try castOrThrow(NMGLatLng.self, $0[1]) }
        return ControlEvent(events: source)
    }
    // map symbol 터치시 해당 심볼 정보 반환 콜백
    var didTapSymbol: ControlEvent<NMFSymbol> {
        let source : Observable<NMFSymbol> = delegateNMFMapView
            .methodInvoked(#selector(NMFMapViewDelegate.mapView(_:didTap:)))
            .map { try castOrThrow(NMFSymbol.self, $0[1]) }
        return ControlEvent(events: source)
    }
    
    var regionDidChangeAnimated: Observable<Bool> {
        return delegateNMFMapView.methodInvoked(#selector(NMFMapViewDelegate.mapView(_:regionDidChangeAnimated:byReason:)))
            .map {
                return $0[1] as? Bool ?? false
        }
    }
}

