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
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var symbolInfoView: UIView!
    
    let viewModel = NMViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naverMapView.delegate = self
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
        
//        naverMapView.mapView.rx.didTapSymbol
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
        
        
        viewModel.locationData
            .emit(to: self.rx.setData)
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func respondToLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let coord = sender.location(in: naverMapView.mapView)
            let latlng = naverMapView.mapView.projection.latlng(from: coord)
            let alertController = UIAlertController(title: "지도 롱클릭", message: latlng.convertString, preferredStyle: .alert)
            present(alertController, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.5), execute: {
                    alertController.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
}


extension NMViewController: NMFMapViewDelegate {
    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        symbolLabel.text = symbol.caption
        return true
    }
}

extension Reactive where Base: NMViewController {
    var setData: Binder<NMGLatLng> {
        return Binder(base) { base, data in
            base.latLabel.text = "경도: \(data.lat)"
            base.lngLabel.text = "위도: \(data.lng)"
        }
    }
}
