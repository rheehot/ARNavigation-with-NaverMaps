//
//  RequestError.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/15.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

// Request Error 관련 열거형 타입
enum RequestError: Error {
    case networkConnection
    case networkDelay
    case requestFailed
}
