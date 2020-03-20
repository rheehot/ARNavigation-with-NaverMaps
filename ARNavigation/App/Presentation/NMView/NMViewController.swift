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

class NMViewController: MapViewController {
    
    var disposeBag = DisposeBag()
    // MARK:- IBOutlet
    @IBOutlet weak var navigationButton: UIButton?
    @IBOutlet weak var symbolLabel: UILabel?
    @IBOutlet weak var latLabel: UILabel?
    @IBOutlet weak var lngLabel: UILabel?
    @IBOutlet weak var symbolInfoView: UIView?
    @IBOutlet weak var searchButton: UIButton?
    
    let viewModel = NMViewModel()
    var coordinate: NMGLatLng?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naverMapView?.delegate = self
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func bind() {
        self.disposeBag = DisposeBag()
        
        naverMapView?.rx.didTapMapView
            .asObservable()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        naverMapView?.rx.regionDidChangeAnimated
            .asObservable()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.locationData
            .emit(to: self.rx.setData)
            .disposed(by: disposeBag)
        
        viewModel.locationData
            .emit(to: self.rx.setCoordinate)
            .disposed(by: disposeBag)
    }
    
    func alertMessage(message: String) {
        let alertController = UIAlertController(title: "지도 롱클릭", message: message, preferredStyle: .alert)
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.5), execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
    }
    // MARK:- IBAction
    @IBAction func respondToLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let coord = sender.location(in: naverMapView?.mapView)
            guard let latlng = naverMapView?.mapView.projection.latlng(from: coord) else { return }
            alertMessage(message: latlng.description)
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showSearchPlace", sender: self)
        // dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearchPlace", let controller = segue.destination as? SearchPlaceViewController {
            controller.coordinate = self.coordinate?.convertLatLng
        }
    }
}
// MARK:- NMFMapViewDelegate
extension NMViewController: NMFMapViewDelegate {
    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        symbolLabel?.text = symbol.caption
        return true
    }
}

extension Reactive where Base: NMViewController {
    var setData: Binder<NMGLatLng> {
        return Binder(base) { base, data in
            base.latLabel?.text = "경도: \(data.lat)"
            base.lngLabel?.text = "위도: \(data.lng)"
        }
    }
    
    var setCoordinate: Binder<NMGLatLng> {
        return Binder(base) { base, data in
            base.coordinate = data
        }
    }
}
