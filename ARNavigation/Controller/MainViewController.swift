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
    @IBOutlet weak var naverMapView: NMFMapView!
    
    // MARK:- Properties
    private var authState: NMFAuthState!
    private let clientId: String = "5uzsyz7j68"
    private let clientSecret: String = "3HHMP9lRHmBhrJAMrMB3EAFMyOCl6VFpAsquN8gJ"
    private var nmMarker = [NMFMarker]()
    private var markerCnt: Int = 0
    private var locationInfo: LocationInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        naverMapView.delegate = self
        
        //        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
        //            print("마커 터치")
        //            return true // 이벤트 소비, didTapMapView 이벤트는 발생하지 않음
        //        }
        
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
        }
        markerCnt += 1
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
        nmMarker.append(marker)
        if markerCnt == 1 {
            marker.mapView = naverMapView
        } else {
            marker.mapView = naverMapView
        }
        print(nmMarker)
    }
}

