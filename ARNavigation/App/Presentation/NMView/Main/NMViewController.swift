//
//  NMViewController.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import NMapsMap
import RxSwift
import RxCocoa

class NMViewController: UIViewController {
    
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var symbolInfoView: UIView!
    let viewModel = NMViewModel()
    let locationManager = CLLocationManager()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaverMapView()
        naverMapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setUpNaverMapView() {
        naverMapView.positionMode = .direction
        naverMapView.mapView.zoomLevel = 15
        naverMapView.showLocationButton = true
        naverMapView.showIndoorLevelPicker = true
    }

    
    func bind() {
        // GPS 수신 동의 체크
        checkGPSAuthorization()
        
//        naverMapView.rx.didTapSymbol
//            .asObservable()
//            .subscribe(onNext : {
//                print($0)
//            })
//            .disposed(by: disposeBag)
        
        naverMapView.rx.didTapMapView
            .asObservable()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        naverMapView.rx.regionDidChangeAnimated
            .asObservable()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
//        locationManager.rx.didUpdateLocations
//            .asObservable()
//            .map {
//                return "경도 : \($0.lat)"
//        }
//        .bind(to: latLabel.rx.text)
//        .disposed(by: disposeBag)
//        
//        locationManager.rx.didUpdateLocations
//            .asObservable()
//            .map {
//                return "경도 : \($0.lng)"
//        }
//        .bind(to: lngLabel.rx.text)
//        .disposed(by: disposeBag)
        
        viewModel.locationChanged.asObservable().map {
            return "경도: \($0!.lng)"
        }.bind(to: lngLabel.rx.text)
        .disposed(by: disposeBag)
        
    }
    
    private func checkGPSAuthorization() {
        locationManager.rx.didChangeAuthorization
        .asObservable()
            .subscribe(onNext: {
                print($0)
            })
        .disposed(by: disposeBag)
    }
}

extension NMViewController: NMFMapViewDelegate {
    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        print(symbol)
        return true
    }
    
    
    
}
