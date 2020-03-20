//
//  PlaceInput.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/03/10.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import Foundation

struct PlaceInput {
    var query: String
    var coordinate: Latlng
    
    init(query: String, coordinate: Latlng) {
        self.query = query
        self.coordinate = coordinate
    }
}
