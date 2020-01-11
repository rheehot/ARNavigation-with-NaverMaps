//
//  SearchViewModel.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import NMapsMap
import RxSwift
import RxCocoa

protocol SearchViewBindable {
    // View에서 ViewModel로 Input
    var navigationButtonTapped: PublishSubject<Void> { get }
    var naverMapViewTapped: PublishSubject<Void> { get }
    
    // ViewModel에서  View로 Output
    var nmMarker: Driver<[NMFMarker]> { get }
    var nmPath: Driver<NMFPath> { get }
    var directionPoins: Driver<[NMGLatLng]> { get }
    var errorMessage: Signal<String> { get }
}

final class SearchViewModel {
    
}
