//
//  SearchRequest.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/08.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

class SearchRequest: RequestProtocol {
    private var clientId: String = ""
    private var clientSecret: String = ""
    
    private func initClientKey() {
        guard let id = Bundle.main.object(forInfoDictionaryKey: Constants.NSLClientId) as? String,
            let secret = Bundle.main.object(forInfoDictionaryKey: Constants.NSLClientSecret) as? String else {
                return
        }
        self.clientId = id
        self.clientSecret = secret
    }
    
    private getSearchURLParameter() -> [String: String] {
        
    }
    
    func createURLRequest(with parameter: [String : String]) -> URLRequest {
        self.initClientKey()
        var urlComponents = URLComponents(string: Constants.NSLbaseURL)
        
        urlComponents?.queryItems = parameter.map{ (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let url = urlComponents?.url else {
            return URLRequest(url: URL(string: "")!)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(self.clientId, forHTTPHeaderField: Constants.NSLClientIdHeader)
        request.setValue(self.clientSecret, forHTTPHeaderField: Constants.NSLClientSecretHeader)
        return request
    }
    
    func request(_ data: NavigationData, completion: @escaping requestCompletionHandler) {
        <#code#>
    }
    
}
