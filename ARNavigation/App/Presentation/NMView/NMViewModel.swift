//
//  NMViewModel.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NMapsMap

protocol NMViewBindable {
    // View에서 ViewModel로 Input
    var navigationButtonTapped: PublishSubject<Void> { get }
    var naverMapViewTapped: PublishSubject<Void> { get }
    
    // ViewModel에서  View로 Output
    var nmMarker: Driver<[NMFMarker]> { get }
    var nmPath: Driver<NMFPath> { get }
    var directionPoins: Driver<[NMGLatLng]> { get }
    var errorMessage: Signal<String> { get }
}

class NMViewModel: NMViewBindable {
    let disposeBag = DisposeBag()
    
    let navigationButtonTapped = PublishSubject<Void>()
    let naverMapViewTapped = PublishSubject<Void>()
    
    let nmMarker: Driver<[NMFMarker]>
    let nmPath: Driver<NMFPath>
    let directionPoins: Driver<[NMGLatLng]>
    let errorMessage: Signal<String>
    
    init(model: NMModel = NMModel()) {
        let pathResult = navigationButtonTapped
            .flatMapLatest(model.getDriving)
            .asObservable()
            .share()
        
        let pathValue = pathResult

    }
    
    
}

