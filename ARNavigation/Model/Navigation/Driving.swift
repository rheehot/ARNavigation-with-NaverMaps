//
//  Driving.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/15.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

struct Trafast: Codable {
    let path: [[Double]]?
}

// 시작과 도착의 경로
struct Route: Codable {
    let trafast: [Trafast]?         // 실시간 빠른길
}

struct Driving: Codable {
    let message: String?
    let route: Route?
}

