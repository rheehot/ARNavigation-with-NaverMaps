//
//  SearchPlaceViewModel.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/03/06.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

final class SearchPlaceViewModel {
    let viewWillApearSubject = PublishSubject<Void>()
    let selectedIndexSubject = PublishSubject<IndexPath>()
    let searchQuerySubject = BehaviorSubject(value: "")
    
    var loading: Driver<Bool>
    var items: Driver<[PlaceInfo]>
    var selectedSearchCell: Driver<String>
    let errorMessage: Signal<String>
    
    init(coordinate: Latlng, initQuery: String) {
        // 모델 생성
        let model = SearchPlaceModel(coordinate: coordinate)
        // ActivityIndicator 생성, drive
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let initialResult = self.viewWillApearSubject
            .asObservable()
            .flatMap { _ in
                model
                    .searchPlaces(input: model.createInputData(query: initQuery))
                    .trackActivity(loading)
        }
        .asObservable()
        .share()
        
        let initValue = initialResult
            .map { result -> [PlaceInfo] in
                guard case .success(let value) = result else { return [] }
                return value
        }
        .asDriver(onErrorJustReturn: [])
        
        let initError = initialResult
            .map { result -> String? in
                guard case .failure(let error) = result else { return nil }
                return error.message
        }
        .filterNil()
        
        let searchResult = self.searchQuerySubject
            .asObservable()
            .filter { $0.count > 2 }
            .throttle(0.2, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query in
                model
                    .searchPlaces(input: model.createInputData(query: query))
                    .trackActivity(loading)
        }
        .asObservable()
        .share()
        
        let searhValue = searchResult
            .map { result -> [PlaceInfo] in
                guard case .success(let value) = result else { return [] }
                return value
        }
        .asDriver(onErrorJustReturn: [])
        
        let searchError = searchResult
            .map { result -> String? in
                guard case .failure(let error) = result else { return nil }
                return error.message
        }
        .filterNil()
        
        let items = Driver.merge(initValue, searhValue)
        
        self.items = items.map { $0.map { $0 } }
        
        self.selectedSearchCell = self.selectedIndexSubject
            .asObservable()
            .withLatestFrom(items) { (indexPath, items) in
                return items[indexPath.item]
        }
        .map { $0.name ?? "" }
        .asDriver(onErrorJustReturn: "")
        
        self.errorMessage = Observable
            .merge(initError, searchError)
            .asSignal(onErrorJustReturn: NetworkError.requestFailed.message ?? "")
    }
}
