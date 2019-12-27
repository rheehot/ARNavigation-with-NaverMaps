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
    func getLocationSearch(data: LocationData) -> Observable<Result<Search, NetworkError>>
}

class APIService: APIServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getDriving(data: NavigationData) -> Observable<Result<Driving, NetworkError>> {
        guard let url = createDrivingComponents(navigationData: data).url else {
            let error = NetworkError.requestFailed
            return .just(.failure(error))
        }
        
        return session.rx.data(request: URLRequest(url: url))
            .map { data in
                do {
                    let drivingData = try JSONDecoder().decode(Driving.self, from: data)
                    return .success(drivingData)
                } catch {
                    return .failure(.requestFailed)
                }
        }
    }
    
    func getLocationSearch(data: LocationData) -> Observable<Result<Search, NetworkError>> {
        guard let url = createSearchComponents(locationData: data).url else {
            let error = NetworkError.requestFailed
            return .just(.failure(error))
        }
        
        return session.rx.data(request: URLRequest(url: url))
            .map { data in
                do {
                    let searchData = try JSONDecoder().decode(Search.self, from: data)
                    return .success(searchData)
                } catch {
                    return .failure(.requestFailed)
                }
        }
    }
    
//    // URLSession + RxSwift 통한 데이터 가져오기
//    func get<T: Codable>(apiReqeust: APIRequest) -> Observable<T> {
//        return Observable<T>.create { observer in
//            let request = apiReqeust.request()
//
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                do {
//                    let jsonData: T = try JSONDecoder().decode(T.self, from: data ?? Data())
//                    observer.onNext(jsonData)
//                } catch let error {
//                    observer.onError(error)
//                }
//                observer.onCompleted()
//            }
//            task.resume()
//            return Disposables.create {
//                task.cancel()
//            }
//        }
//    }
}

private extension APIService {
    
    func createDrivingComponents(navigationData: NavigationData) -> URLComponents {
        let parameter: [String: String] = [
            "start": navigationData.startLocation.convertString,
            "goal": navigationData.goalLocation.convertString,
            "option": NaverDirectionAPI.trafast
        ]
        var components = URLComponents()
        components.scheme = NaverDirectionAPI.scheme
        components.host = NaverDirectionAPI.host
        components.path = NaverDirectionAPI.path
        components.queryItems = parameter.map { URLQueryItem(name: $0, value: $1) }
        
        return components
    }
    
    func createSearchComponents(locationData: LocationData) -> URLComponents {

        let parameter: [String: String] = [
            "query": locationData.locationName,
            "coordinate": locationData.curLocation.convertString
        ]
        var components = URLComponents()
        components.scheme = NaverSearchAPI.scheme
        components.host = NaverSearchAPI.host
        components.path = NaverSearchAPI.path
        components.queryItems = parameter.map { URLQueryItem(name: $0, value: $1)}
        
        return components
    }
    
}
