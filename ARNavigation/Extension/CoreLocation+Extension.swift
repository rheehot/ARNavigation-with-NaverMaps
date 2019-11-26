//
//  ExtensionCoreLocation.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/19.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import CoreLocation

extension CLLocationManagerDelegate {
    
    // 현재 위치 데이터(경위도) 생성
    // 문제점: 신주소 ex 대구광역시 북구 대현로19 56" 이렇게 placemark 값이 나올 시 subLocality 값이 nil 이 나옴
    private func createCurrentLocationData(_ location: CLLocation, placemark: CLPlacemark) -> LocationData? {
        if let locality = placemark.locality , let subLocality = placemark.subLocality {
            let locationName = locality + " " + subLocality
            var currentLocationData = LocationData()
            currentLocationData.locationName = locationName
            currentLocationData.latitude = location.coordinate.latitude
            currentLocationData.longitude = location.coordinate.longitude
            return currentLocationData
        } else {
            print("현재 위치 데이터 생성 실패")
        }
        return nil
    }
    
    // 현재 위치 요청
    func getCurrentLocation(_ location: CLLocation, completion: @escaping(Bool, LocationData?) -> Void) {
        
        let geoCoder = CLGeocoder()
        
        if #available(iOS 12.0, *) {
            geoCoder.reverseGeocodeLocation(location, preferredLocale: Locale.init(identifier: "KR")) { (placemarks, error) in
                guard let placemark = placemarks?.first, error == nil else {
                    completion(false, nil)
                    return
                }
                if let currentLocationData = self.createCurrentLocationData(location, placemark: placemark) {
                    completion(true, currentLocationData)
                    return
                } else {
                    print("geocoder 실패")
                    completion(false, nil)
                }
               
            }
        } else {
            UserDefaults.standard.set(["KR"], forKey: "AppleLanguages")
            geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
                UserDefaults.standard.removeObject(forKey: "AppleLanguages")
                guard let placemark = placemarks?.first, error == nil else {
                    completion(false, nil)
                    return
                }
                if let currentLocationData = self.createCurrentLocationData(location, placemark: placemark) {
                    completion(true, currentLocationData)
                    return
                }
                completion(false, nil)
            }
        }
    }
}
