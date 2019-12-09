//
//  DirectionRequest.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/15.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import NMapsMap

class DirectionRequest: RequestProtocol {
    
    private var clientId: String = ""
    private var clientSecret: String = ""
    
    private func initClientKey() {
        guard let id = Bundle.main.object(forInfoDictionaryKey: Constants.NMFClientId) as? String,
            let secret = Bundle.main.object(forInfoDictionaryKey: Constants.NMFClientSecret) as? String else {
                return
        }
        self.clientId = id
        self.clientSecret = secret
    }
    
    func createURLRequest(_ start: String, _ goal: String) -> URLRequest {
        self.initClientKey()
        var urlComponents = URLComponents(string: Constants.NMbaseURL)
        let start = start
        let goal = goal
        let parameter: [String: String] = [
            "start": start,
            "goal": goal,
            "option": Constants.trafast
        ]
        urlComponents?.queryItems = parameter.map{ (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let url = urlComponents?.url else {
            return URLRequest(url: URL(string: "")!)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(self.clientId, forHTTPHeaderField: Constants.NMClientIdHeader)
        request.setValue(self.clientSecret, forHTTPHeaderField: Constants.NMClientSecretHeader)
        
        return request
    }
    
    func request(_ data: NavigationData, completion: @escaping requestCompletionHandler) {
        let start = data.startLocation.convertString
        let goal = data.goalLocation.convertString
        let request = createURLRequest(start, goal)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(false, nil, RequestError.requestFailed)
                return
            }
            guard let data = data else {
                completion(false, nil, RequestError.requestFailed)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let driving = try decoder.decode(Driving.self, from: data)
                completion(true, driving, nil)
            } catch {
                print("error trying to convert data to JSON")
                completion(false, nil, RequestError.requestFailed)
            }
        }.resume()
    }
}

