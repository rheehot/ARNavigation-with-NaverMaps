//
//  LocationData.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/15.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import NMapsMap

struct LocationData {
    var locationName: String?           // 위치 이름
    var latitude: Double?               // 위도
    var longitude: Double?              // 경도
}

struct NavigationData {
    var startLocation: NMGLatLng?    // 시작지점
    var goalLocation: NMGLatLng?     // 도착지점
}




