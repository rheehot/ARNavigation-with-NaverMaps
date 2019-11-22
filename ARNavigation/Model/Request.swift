//
//  Request.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/15.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import UIKit

class Request: RequestProtocol {
    // Client Key
    private let clientId: String = Bundle.main.object(forInfoDictionaryKey: "NMFClientId") as! String
    private let clientSecret: String = Bundle.main.object(forInfoDictionaryKey: "NMFClientSecret") as! String
    
    // URLComponents 생성
    func createURLComponents() -> URLComponents {
        // driving 기본 base url
        let baseURL = "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving"
        let urlComponents = URLComponents(string: baseURL)
        return urlComponents!
    }
    
    // Driving API 요청
    func request(_ data: LocationInfo, completion: @escaping requestCompletionHandler) {
        var components = createURLComponents()
        // ex) start=127.1058342,37.359708&goal=129.075986,35.179470&option=trafast
        
        // 네트워크 인디케이터 생성
        // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let start = data.start
        let goal = data.goal
        let parameter: [String: String] = [
            "start": start,
            "goal": goal,
            "option": "trafast"
        ]
        // parameter 추가
        components.queryItems = parameter.map{ (key, value) in
            URLQueryItem(name: key, value: value)
        }
        // url 가져오기
        guard let url = components.url else {
            completion(false, nil, RequestError.requestFailed)
            return
        }
        
        // reqeust 객체 생성
        var request = URLRequest(url: url)
        // request Http 통신 설정
        request.httpMethod = "GET"
        request.setValue(self.clientId, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.setValue(self.clientSecret, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        // JSON 데이터 요청
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let data = data else {
                    print("Empty data")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let driving = try decoder.decode(Driving.self, from: data)
                    completion(true, driving, nil)
                } catch {
                    print("error trying to convert data to JSON")
                    print(error)
                }
            }.resume()
        }
        // 네트워크 인디케이터 종료
        //UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
