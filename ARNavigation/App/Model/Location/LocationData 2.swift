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
    var locationName: String
    var curLocation: NMGLatLng
}

struct NavigationData {
    var locationData: LocationData?
    var startLocation: NMGLatLng
    var goalLocation: NMGLatLng
    
    init(_ start: NMGLatLng, _ goal: NMGLatLng) {
         self.startLocation = start
         self.goalLocation = goal
     }
}




