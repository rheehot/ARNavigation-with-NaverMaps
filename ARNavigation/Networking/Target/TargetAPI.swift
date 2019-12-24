//
//  TargetAPI.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

enum TargetAPI {
    case drivingAPI
    case locationSearchAPI
}

extension TargetAPI {
    var scheme: String {
        switch self {
        case .drivingAPI, .locationSearchAPI:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        case .drivingAPI:
            return Constants.NMbaseURL
        case .locationSearchAPI:
            return Constants.NSLbaseURL
        }
    }
    
    var clientId: String {
        switch self {
        case .drivingAPI:
            return Constants.NMFClientId
        case .locationSearchAPI:
            return Constants.NSLClientId
        }
    }
    
    var clientSecret: String {
        switch self {
        case .drivingAPI:
            return Constants.NMFClientSecret
        case .locationSearchAPI:
            return Constants.NSLClientSecret
        }
    }
    
    var clientIdHeader: String {
        switch self {
        case .drivingAPI:
            return Constants.NMClientIdHeader
        case .locationSearchAPI:
            return Constants.NSLClientIdHeader
        }
    }
    
    var clientSecretHeader: String {
        switch self {
        case .drivingAPI:
            return Constants.NMClientSecretHeader
        case .locationSearchAPI:
            return Constants.NSLClientSecretHeader
        }
    }
}
