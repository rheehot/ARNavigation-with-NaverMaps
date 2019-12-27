//
//  NMGLatLng+Extension.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/26.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import NMapsMap

extension NMGLatLng {
    var convertString: String {
        "\(self.lng),\(self.lat)"
    }
    
    var convertedLatLng: NMGLatLng {
         self.lat = floor((self.lat) * 1000000) / 1000000
         self.lng = floor((self.lng) * 1000000) / 1000000
         return self
     }
}
