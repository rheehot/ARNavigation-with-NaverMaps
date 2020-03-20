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

protocol APIService {
    func directions(input: DirectionInput) -> Observable<Result<Directions, NetworkError>>
    func searchPlaces(input: PlaceInput) -> Observable<Result<[PlaceInfo], NetworkError>>
}

class APIServiceImpl: APIService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    // Direction API Driving 요청
    func directions(input: DirectionInput) -> Observable<Result<Directions, NetworkError>> {
        guard let url = createDrivingComponents(input: input).url else {
            let error = NetworkError.requestFailed
            return .just(.failure(error))
        }
        
        return session.rx.data(request: URLRequest(url: url))
            .map { data in
                do {
                    let drivingData = try JSONDecoder().decode(Directions.self, from: data)
                    return .success(drivingData)
                } catch {
                    return .failure(.requestFailed)
                }
        }
    }
    // Search API 요청
    // TODO: Result Type으로 변경해야함
    func searchPlaces(input: PlaceInput) -> Observable<Result<[PlaceInfo], NetworkError>> {
        guard let url = createSearchComponents(input: input).url else {
            let error = NetworkError.requestFailed
            return .just(.failure(error))
        }
        var request = URLRequest(url: url)
        // TODO: Private Key, Token Key등의 관리법에 대해 정리가 필요
        let (clientId, clientSecret) = apiKey()
        request.setValue(clientId, forHTTPHeaderField: NaverSearchAPI.NSLClientIdHeader)
        request.setValue(clientSecret, forHTTPHeaderField: NaverSearchAPI.NSLClientSecretHeader)
        
        return session.rx.data(request: request)
            .map { data in
                do {
                    let response = try JSONDecoder().decode(Place.self, from: data)
                    return .success(response.places ?? [])
                } catch {
                    return .failure(.requestFailed)
                }
        }
    }
}

private extension APIServiceImpl {
    
    private func createDrivingComponents(input: DirectionInput) -> URLComponents {
        let parameter: [String: String] = [
            "start": input.start.convertString,
            "goal": input.goal.convertString,
            "option": NaverDirectionAPI.trafast
        ]
        var components = URLComponents()
        components.scheme = NaverDirectionAPI.scheme
        components.host = NaverDirectionAPI.host
        components.path = NaverDirectionAPI.path
        components.queryItems = parameter.map { URLQueryItem(name: $0, value: $1) }
        
        return components
    }
    
    private func createSearchComponents(input: PlaceInput) -> URLComponents {
        let parameter: [String: String] = [
            "query": input.query,
            "coordinate": input.coordinate.convertString
        ]
        var components = URLComponents()
        components.scheme = NaverSearchAPI.scheme
        components.host = NaverSearchAPI.host
        components.path = NaverSearchAPI.path
        components.queryItems = parameter.map { URLQueryItem(name: $0, value: $1) }
        
        return components
    }
    
    private func apiKey() -> (String, String) {
        guard let clientId: String = Bundle.main.object(forInfoDictionaryKey: "NMFClientId") as? String, let clientSecret: String = Bundle.main.object(forInfoDictionaryKey: "NMFClientSecret") as? String else { return ("", "") }
        
        return (clientId, clientSecret)
    }
}
