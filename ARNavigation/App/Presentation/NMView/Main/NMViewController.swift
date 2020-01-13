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
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var symbolInfoView: UIView!
    
    let viewModel = NMViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaverMapView()
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
        self.disposeBag = DisposeBag()
        // GPS 수신 동의 체크
        // checkGPSAuthorization()
        
        naverMapView.rx.didTapSymbol
            .asObservable()
            .subscribe(onNext : {
                print($0)
            })
            .disposed(by: disposeBag)
        
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
        
        
        viewModel.locationData
            .emit(to: self.rx.setData)
            .disposed(by: disposeBag)
        
    }
    
    //    private func checkGPSAuthorization() {
    //        locationManager.rx.didChangeAuthorization
    //            .asObservable()
    //            .subscribe(onNext: {
    //                print($0)
    //            })
    //            .disposed(by: disposeBag)
    //    }
}

extension Reactive where Base: NMViewController {
    var setData: Binder<NMGLatLng> {
        return Binder(base) { base, data in
            print(data)
            base.latLabel.text = "경도: \(data.lat)"
            base.lngLabel.text = "위도: \(data.lng)"
        }
    }
}
