//
//  MainViewModel.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/05.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import NMapsMap


class MainViewModel {
    let apiRequest: Request
    
    private var nmMarker = [NMFMarker]()
    private var nmPath: NMFPath?
    private var directionPoints = [NMGLatLng]()
    
    var updateLoadingStatus: (() -> ())?
    
    init(apiRequest: Request = Request()) {
        self.apiRequest = apiRequest
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    func requestFetchData() {
        self.isLoading = true
        guard let start = nmMarker.first?.position,
            let goal = nmMarker.last?.position else {
                return
        }
        let navigationData = NavigationData(start, goal)
        apiRequest.request(navigationData) { [weak self] (isSuccess, data, error) in
            self?.isLoading = false
            if isSuccess {
                guard let driving = data as? Driving  else { return }
                self?.makePoints(driving.route?.trafast?.first?.path)
                print("성공")
            } else {
                print("실패")
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func processFetchMarker(with latlng: NMGLatLng, mapView naverMapView: NMFMapView) {
        if self.nmMarker.count == 2 {
            resetMapMarker()
            return
        }
        self.addMarker(with: latlng, mapView: naverMapView)
    }
    
    private func addMarker(with latLng: NMGLatLng, mapView naverMapView: NMFMapView) {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: latLng.lat, lng: latLng.lng)
        nmMarker.append(marker)
        marker.mapView = naverMapView
    }
    
    private func resetMapMarker() {
        nmMarker.forEach { $0.mapView = nil }
        nmMarker.removeAll()
        self.removeAllPoints()
        nmPath?.mapView = nil
    }
    
    func processFetchPath(naverMapView: NMFMapView) {
        self.nmPath = NMFPath(points: self.getDirectionPoints())
        self.nmPath?.mapView = naverMapView
    }
    
    func removeAllPoints() {
        self.directionPoints.removeAll()
    }
    
    func getDirectionPoints() -> [NMGLatLng] {
        return self.directionPoints
    }
    
    private func makePoints(_ paths: [[Double]]?) {
        paths?.forEach({ (path) in
            guard let lat = path.last,
                let lng = path.first else {
                    return
            }
            let latlng = NMGLatLng(lat: lat, lng: lng)
            self.directionPoints.append(latlng)
        })
    }
    
}
