//
//  APIService.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import NMapsMap
import RxSwift

protocol APIServiceProtocol {
    func getDriving(data: NavigationData) -> Observable<Result<Driving, NetworkError>>
    func getLocationSearch(name: String) -> Observable<Result<Search, NetworkError>>
}

class APIService: APIServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getDriving(data: NavigationData) -> Observable<Result<Driving, NetworkError>> {

    }
    
    func getLocationSearch(name: String) -> Observable<Result<Search, NetworkError>> {
        <#code#>
    }
    
    // URLSession + RxSwift 통한 데이터 가져오기
    func get<T: Codable>(apiReqeust: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiReqeust.request()
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let jsonData: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(jsonData)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

private extension APIService {
    
    func createDrivingComponents(start: String, goal: String) -> URLComponents {
        // parameter 설정
        let parameter: [String: String] = [
            "start": start,
            "goal": goal,
            "option": NaverAPI.trafast
        ]
        // TODO: schem. path, parameter 설정 추가 해야함 지금은 urlString
        var components = URLComponents(string: NaverAPI.NMbaseURL )
        components?.queryItems = parameter.map { URLQueryItem(name: $0, value: $1) }
        
        return components
    }
    
    func createSearchComponents(name: String) -> URLComponents {
        
    }
}
