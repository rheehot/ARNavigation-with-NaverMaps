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

class NMViewModel {
    
    // OutPut
    var directionPoints: Signal<[NMGLatLng]>
    var nmMarker: Signal<[NMFMarker]>
    var nmPath: Signal<NMFPath>
    
    private let apiService: APIService
    
}
