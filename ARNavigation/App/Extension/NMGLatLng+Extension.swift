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
    var convertString: String { "\(self.lng),\(self.lat)" }

    var convertLatLng: Latlng { return Latlng(lat: self.lat, lng: self.lng) }
}
