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
    
    func createURLRequest(_ start: String, _ goal: String) -> URLRequest {
        self.initClientKey()
        var urlComponents = URLComponents(string: Constants.NSLbaseURL )
        
    }
    
}
