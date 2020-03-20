//
//  NavigationType.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

enum NavigationType: String {
    case trafast = "trafast"                              // 실시간 빠른길
    case tracomfort = "tracomfort"                        // 실시간 편한길
    case traoptimal = "traoptimal"                        // 실시간 최적
    case traavoidtoll = "traavoidtoll"                    // 무료 우선
    case traavoidcaronly = "traavoidcaronly"              // 자동차 전용도로 회피 우선
}
