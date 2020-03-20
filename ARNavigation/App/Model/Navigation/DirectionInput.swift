//
//  DirectionInput.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/03/10.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import Foundation
// https://apidocs.ncloud.com/ko/ai-naver/maps_directions_15/driving/#multiple-request-position-format-list
struct DirectionInput {
    var start: Latlng
    var goal: Latlng
    
    init(start: Latlng, goal: Latlng) {
        self.start = start
        self.goal = goal
    }
}
