//
//  TargetType.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

protocol TargetType {
    var targetAPI: TargetAPI { get }
    var method: HTTPMethod { get }
    var paths: [String] { get }
    var paramether: [String: String]? { get }
    var body: Data? { get }
}
