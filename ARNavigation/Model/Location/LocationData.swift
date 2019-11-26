//
//  LocationData.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/15.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

struct LocationData {
    var locationName: String?           // 위치 이름
    var latitude: Double?               // 위도
    var longitude: Double?              // 경도
}

struct LocationInfo {
    var startLocation: LocationData?    // 시작지점
    var goalLocation: LocationData?     // 도착지점
    
    var start: String {
        return "\(self.startLocation?.longitude ?? 0),\(self.startLocation?.latitude ?? 0)"
    }
    
    var goal: String {
        return "\(self.goalLocation?.longitude ?? 0),\(self.goalLocation?.latitude ?? 0)"
    }
}



