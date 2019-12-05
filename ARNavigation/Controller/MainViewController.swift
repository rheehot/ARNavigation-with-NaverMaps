//
//  ViewController.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/13.
//  Copyright © 2019 youngjun goo. All rights reserved.
//
import UIKit
import NMapsMap

class MainViewController: UIViewController {
    
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    
    // MARK: - Properties
    private var nmMarker = [NMFMarker]()
    private var nmPath: NMFPath?
    private var mainViewModel = MainViewModel()
    
    // MARK:- Properties
    private var authState: NMFAuthState!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NMFLocationManager.sharedInstance()?.add(self)
        setUpNaverMapView()
    }
    
    // MARK: - IBAction
    @IBAction func tappedNaviButton(_ sender: UIButton) {
        mainViewModel.requestFetchData()
    }
    
    @IBAction func tappedARNaviButton(_ sender: UIButton) {

    }
    
    private func makePathOverlay() {
        DispatchQueue.main.async {
            // self.nmPath = NMFPath(points: self.viewModel.getDirectionPoints())
            // self.nmPath?.mapView = self.naverMapView.mapView
        }
    }
    
    private func setUpNaverMapView() {
        naverMapView.delegate = self
        naverMapView.positionMode = .direction
        naverMapView.mapView.zoomLevel = 15
        naverMapView.showLocationButton = true
        naverMapView.showIndoorLevelPicker = true
    }
}

// MARK: - NMFMapViewDelegate
extension MainViewController: NMFMapViewDelegate {
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        print("\(latlng.lat), \(latlng.lng)")
        
        if self.nmMarker.count == 2 {
            resetMapMarker()
            return
        }
        self.addMarker(with: latlng)
    }
    
    private func addMarker(with latLng: NMGLatLng) {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: latLng.lat, lng: latLng.lng)
        nmMarker.append(marker)
        marker.mapView = naverMapView.mapView
    }
    
    private func resetMapMarker() {
        nmMarker.forEach { $0.mapView = nil }
        nmMarker.removeAll()
        self.mainViewModel.removeAllPoints()
        nmPath?.mapView = nil
    }
}

// MARK: - NMFLocationManagerDelegate
extension MainViewController: NMFLocationManagerDelegate {
    
    func locationManager(_ locationManager: NMFLocationManager!, didUpdateLocations locations: [Any]!) {
        guard let curLocation = locations.last as? CLLocation else { return }
        self.latLabel.text = "경도 : \(curLocation.coordinate.latitude)"
        self.lngLabel.text = "위도 : \(curLocation.coordinate.longitude)"
    }
}
