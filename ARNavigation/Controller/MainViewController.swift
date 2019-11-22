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
    // MARK: - IBOutlet
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    
    // MARK: - Properties
    private var nmMarker = [NMFMarker]()
    private var nmPath: NMFPath?
    private var viewModel = Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NMFLocationManager.sharedInstance()?.add(self)
        setUpNaverMapView()
    }
    
    // MARK: - IBAction
    @IBAction func tappedNaviButton(_ sender: UIButton) {
        self.requestNavigationData()
    }
    
    @IBAction func tappedARNaviButton(_ sender: UIButton) {
        //         let arVC = ARViewController()
        //         guard let path = drivingPath else { return }
        //         arVC.getDrivePath(path)
        //         self.present(arVC, animated: true)
    }
    
    // MARK: - Request
    private func requestNavigationData() {
        guard let start = nmMarker.first?.position,
              let goal = nmMarker.last?.position else {
                return
        }
        let data = Direction(start, goal)
        
        viewModel.request(data) { [weak self] (isSuccess, data, error) in
            if isSuccess {
                self?.makePathOverlay()
                print("성공")

            } else {
                print("실패")
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    
    private func makePathOverlay() {
        nmPath = NMFPath(points: self.viewModel.getDirectionPoints())
        nmPath?.mapView = naverMapView.mapView
    }
    
    func setUpNaverMapView() {
        if let nmView = self.naverMapView {
            nmView.delegate = self
            nmView.positionMode = .direction
            nmView.mapView.zoomLevel = 15
            nmView.showLocationButton = true
            nmView.showIndoorLevelPicker = true
        } else {
            print("naverMapView's IBOutlet이 소실되었습니다.")
        }
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
        self.viewModel.removeAllPoints()
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
