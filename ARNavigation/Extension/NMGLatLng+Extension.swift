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
        return "\(self.lng),\(self.lat)"
    }
}
