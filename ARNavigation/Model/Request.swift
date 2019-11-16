//
//  Request.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/15.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

class Request: RequestProtocol {
    
    private let clientId: String = "5uzsyz7j68"
    private let clientSecret: String = "3HHMP9lRHmBhrJAMrMB3EAFMyOCl6VFpAsquN8gJ"
    
    func createURLComponents() -> URLComponents? {
        // driving 기본 base url
        let baseURL = "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving"
        
        guard let urlComponents = URLComponents(string: baseURL) else {
            return URLComponents(string: "")
        }
        return urlComponents
    }
    
    func request(_ data: LocationData, completion: @escaping requestCompletionHandler) {
        var components = createURLComponents()
        // ex) start=127.1058342,37.359708&goal=129.075986,35.179470&option=trafast
        let parameter: [String: String] = [
            "start": "127.1058342,37.359708",
            "goal": "129.075986,35.179470",
            "option": "trafast"
        ]
        // parameter 추가
        components?.queryItems = parameter.map{ (key, value) in
            URLQueryItem(name: key, value: value)
        }
        // url 가져오기
        guard let url = components?.url else {
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
                print(driving.route?.trafast?.first?.path)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
            }
        }.resume()
    }
}
