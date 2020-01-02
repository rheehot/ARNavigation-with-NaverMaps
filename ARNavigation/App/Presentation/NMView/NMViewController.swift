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
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaverMapView()
    }
    
    private func setUpNaverMapView() {
        naverMapView.positionMode = .direction
        naverMapView.mapView.zoomLevel = 15
        naverMapView.showLocationButton = true
        naverMapView.showIndoorLevelPicker = true
    }
    
    func bind() {
        naverMapView.rx.didTapMapView
            .asObservable()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        naverMapView.rx.currentLocationChange
            .asObservable()
            .map {
                guard let curLocation = $0.last as? CLLocation else { return "" }
                return "경도: \(curLocation.coordinate.latitude)"
        }
        .bind(to: latLabel.rx.text)
        .disposed(by: disposeBag)
        
        naverMapView.rx.currentLocationChange
            .asObservable()
            .map {
                guard let curLocation = $0.last as? CLLocation else { return "" }
                return "위도: \(curLocation.coordinate.longitude)"
        }
        .bind(to: lngLabel.rx.text)
        .disposed(by: disposeBag)
        
    }
    
}





