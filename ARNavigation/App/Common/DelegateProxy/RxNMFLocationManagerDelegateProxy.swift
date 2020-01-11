////
////  RxNMFLocationManagerDelegateProxy.swift
////  ARNavigation
////
////  Created by youngjun goo on 2020/01/10.
////  Copyright © 2020 youngjun goo. All rights reserved.
////
//
//import RxCocoa
//import RxSwift
//import NMapsMap
//
//class RxNMFLocationManagerDelegateProxy: DelegateProxy<NMFLocationManager, NMFLocationManagerDelegate>, DelegateProxyType, NMFLocationManagerDelegate {
//    static func registerKnownImplementations() {
//        self.register { (manager) -> RxNMFLocationManagerDelegateProxy in
//            RxNMFLocationManagerDelegateProxy(parentObject: manager, delegateProxy: self)
//        }
//    }
//    
//    static func currentDelegate(for object: NMFLocationManager) -> NMFLocationManagerDelegate? {
//        return 
//    }
//    
//    static func setCurrentDelegate(_ delegate: NMFLocationManagerDelegate?, to object: NMFLocationManager) {
//        <#code#>
//    }
//    
//    
//}
//
