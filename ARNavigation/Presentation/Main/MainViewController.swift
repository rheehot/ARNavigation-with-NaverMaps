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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBarView: UIView!
    
    // MARK: - Properties
    private var nmMarker = [NMFMarker]()
    private var nmPath: NMFPath?
    lazy var mainViewModel: MainViewModel = {
        return MainViewModel()
    }()
    
    // MARK:- Properties
    private var authState: NMFAuthState!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NMFLocationManager.sharedInstance()?.add(self)
        setUpNaverMapView()
    }
    
    // MARK: - IBAction
    @IBAction func tappedNaviButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.mainViewModel.requestFetchData()
            self.mainViewModel.processFetchPath(naverMapView: self.naverMapView.mapView)
        }
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
        naverMapView.addSubview(self.searchBarView)
    }
    
    private func initializeViewModel() {
        mainViewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.mainViewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        // Naver Map indicatior animating
                    })
                }else{
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        // Naver Map indicatior animating
                    })
                }
            }
        }
    }
    
}

// MARK: - NMFMapViewDelegate
extension MainViewController: NMFMapViewDelegate {
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        print("\(latlng.lat), \(latlng.lng)")
        self.mainViewModel.processFetchMarker(with: latlng, mapView: self.naverMapView.mapView)
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
