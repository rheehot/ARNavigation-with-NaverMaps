//
//  Common.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/08.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

struct NaverSearchAPI {
    static let scheme: String = "https"
    static let host: String = "openapi.naver.com"
    static let path = "/v1/search/local.json"
    // Naver Search
    static let NSLClientId: String = "NSLClientId"
    static let NSLClientSecret: String = "NSLClientSecret"
    static let NSLbaseURL: String = "https://openapi.naver.com/v1/search/local.json"
    static let NSLClientIdHeader: String = "X-Naver-Client-Id"
    static let NSLClientSecretHeader: String = "X-Naver-Client-Secret"
}

struct NaverDirectionAPI {
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
