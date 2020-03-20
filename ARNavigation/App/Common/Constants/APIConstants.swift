//
//  Common.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/08.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

public struct NaverSearchAPI {
    static let scheme: String = "https"
    static let host: String = "naveropenapi.apigw.ntruss.com"
    static let path = "/map-place/v1/search"
    // Naver Search
    static let NSLbaseURL: String = "https://naveropenapi.apigw.ntruss.com/map-place/v1/search"
    static let NSLClientIdHeader: String = "X-NCP-APIGW-API-KEY-ID"
    static let NSLClientSecretHeader: String = "X-NCP-APIGW-API-KEY"
}

public struct NaverDirectionAPI {
    static let scheme: String = "https"
    static let host: String = "naveropenapi.apigw.ntruss.com"
    static let path: String = "map-direction/v1/driving"
    // Naver Driving
    static let NMFClientId: String = "NMFClientId"
    static let NMFClientSecret: String = "NMFClientSecret"
    static let NMbaseURL: String = "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving"
    static let NMClientIdHeader: String = "X-NCP-APIGW-API-KEY-ID"
    static let NMClientSecretHeader: String = "X-NCP-APIGW-API-KEY"
    static let trafast: String = "trafast"
}

