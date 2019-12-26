//
//  TargetType.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

protocol APIRequest {
    var targetAPI: TargetAPI { get }
    var method: HTTPMethod { get }
    var paths: [String] { get }
    var parameter: [String: String] { get }
    var body: Data? { get }
}

extension APIRequest {
    func request() -> URLRequest {
        var urlComponents = URLComponents(string: self.targetAPI.baseURL)
        
        urlComponents?.queryItems = parameter.map { URLQueryItem(name: $0, value: $1)}
        guard let url = urlComponents?.url else {
            fatalError("Could not get url")
        }
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.addValue(targetAPI.clientId, forHTTPHeaderField: targetAPI.clientIdHeader)
            request.addValue(targetAPI.clientSecret, forHTTPHeaderField: targetAPI.clientSecretHeader)
            return request
        }()
        
        return request
    }
}


