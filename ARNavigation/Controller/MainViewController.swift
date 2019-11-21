//
//  ViewController.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/13.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import NMapsMap
import CoreLocation

class MainViewController: UIViewController {
    // MARK:- IBOutlet
    @IBOutlet weak var naverMapView: NMFNaverMapView! {
        didSet {
            self.naverMapView.positionMode = .direction
            self.naverMapView.mapView.zoomLevel = 15
        }
    }
    
    // MARK:- Properties
    private var authState: NMFAuthState!
    private var nmMarker = [NMFMarker]()
    private var markerCnt: Int = 0
    private var locationInfo: LocationInfo?
    private var currentLocationData: LocationData?
    private var drivingData: Driving?
    private var drivingPath: [[Double]]?
    private var nmPath: NMFPath?
    
    private var locationManager = CLLocationManager()
    private var locationRequestCompletion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naverMapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            locationManager.requestLocation()
        }
        
    }
    
    @IBAction func tappedNaviButton(_ sender: UIButton) {
        requestNavigationData { (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.makePathOverlay()
                }
            } else {
                print("실패")
            }
        }
    }
    
    @IBAction func tappedARNaviButton(_ sender: UIButton) {
        let arVC = ARViewController()
        guard let path = drivingPath else { return }
        arVC.getDrivePath(path)
        
        self.present(arVC, animated: true)
    }
    
    func requestNavigationData(completion: @escaping (Bool) -> Void) {
        
        guard let startLat = nmMarker.first?.position.lat,
            let startLng = nmMarker.first?.position.lng,
            let goalLat = nmMarker.last?.position.lat,
            let goalLng = nmMarker.last?.position.lng else {
                return
        }

        var data = LocationInfo()
        data.startLocation = extractLocationData(startLat, startLng)
        data.goalLocation = extractLocationData(goalLat, goalLng)
        // 데이터 요청
        Request().request(data) { (isSuccess, data, error) in
            if isSuccess, let drivingData = data as? Driving {
                self.drivingData = drivingData
                completion(true)
                print("성공")
            } else {
                print("실패")
                print(error?.localizedDescription as Any)
                completion(false)
            }
        }
    }
    
    // 요청데이터 포맷(소수점 7자리까지)으로 변환하는 작업
    func extractLocationData(_ lat: Double?, _ lng: Double?) -> LocationData {
        guard let lat = lat, let lng = lng else { return LocationData() }
        var locationData = LocationData()
        locationData.latitude = floor((lat) * 1000000) / 1000000
        locationData.longitude = floor((lng) * 1000000) / 1000000
        
        return locationData
    }
}

extension MainViewController: NMFMapViewDelegate {
    
    // 네이버 지도 탭 시 호출되는 Callback Method
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        print("\(latlng.lat), \(latlng.lng)")
        if self.markerCnt == 2 {
            markerCnt = 0
            nmMarker.forEach { $0.mapView = nil }
            nmMarker.removeAll()
            drivingPath?.removeAll()
            nmPath?.mapView = nil
        }
        markerCnt += 1
        
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
        nmMarker.append(marker)
        marker.mapView = naverMapView.mapView
    }
    
    // path 시각화
    func makePathOverlay() {

        self.drivingPath = self.drivingData?.route?.trafast?.first?.path
        var points: [NMGLatLng] = []
        drivingPath?.forEach({ (path) in
            let latlng = NMGLatLng(lat: path.last!, lng: path.first!)
            points.append(latlng)
        })
        nmPath = NMFPath(points: points)
        nmPath?.mapView = naverMapView.mapView
    }
}

extension MainViewController: CLLocationManagerDelegate {
    // error 가 발생시 호출되는 CallBack 함수
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locations.first, !locationRequestCompletion {
            locationRequestCompletion = true
            getCurrentLocation(locations.first!) { (isSuccess, data) in
                if isSuccess, let currentLocation = data {
                    self.currentLocationData = currentLocation
                    print("성공: \(currentLocation)")
                } else {
                    print("현재 위치 데이터 요청 실패")
                }
            }
        }
    }
}
