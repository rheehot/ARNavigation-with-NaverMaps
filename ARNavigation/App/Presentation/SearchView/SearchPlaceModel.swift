//
//  SearchPlaceModel.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import RxSwift

struct SearchPlaceModel {
    let apiService: APIService
    let coordinate: Latlng
    
    init(apiService: APIService = APIServiceImpl(), coordinate: Latlng) {
        self.apiService = apiService
        self.coordinate = coordinate
    }
    
    func searchPlaces(input: PlaceInput) -> Observable<Result<[PlaceInfo], NetworkError>> {
        return apiService.searchPlaces(input: input)
    }

    func createInputData(query: String) -> PlaceInput {
        return PlaceInput(query: query, coordinate: coordinate)
    }
}
