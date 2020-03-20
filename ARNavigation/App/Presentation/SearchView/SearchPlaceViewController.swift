//
//  SearchPlaceViewController.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import NMapsMap
import RxSwift
import RxCocoa

class SearchPlaceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchTextFiled = UITextField()
    
    private var viewModel: SearchPlaceViewModel?
    var disposeBag = DisposeBag()
    // 굳이 Data 변수를 둘 필요가 있을지 -> ViewModel이 알고 있어야하는 데이터
    var coordinate: Latlng?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setComponents()
        setLayout()
        bind()
    }
    
    func setComponents() {
        view.backgroundColor = .white
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = nil
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        registerTableViewXib()
    }
    
    func setLayout() {
        tableView?.tableHeaderView = searchController.searchBar
        tableView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func registerTableViewXib() {
        let nibName = UINib(nibName: SearchPlaceTableViewCell.reusableIdentifier, bundle: nil)
        tableView?.register(nibName, forCellReuseIdentifier: SearchPlaceTableViewCell.cellIdentifier)
    }
    
    func bind() {
        guard let tableView = self.tableView, let viewModel = self.viewModel else { return }
        self.disposeBag = DisposeBag()
        
        rx.viewWillAppear
            .asObservable()
            .bind(to: viewModel.viewWillApearSubject)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .asObservable()
            .bind(to: viewModel.selectedIndexSubject)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty
            .asObservable()
            .bind(to: viewModel.searchQuerySubject)
            .disposed(by: disposeBag)
        
        viewModel.items
            .drive((tableView.rx.items(cellIdentifier: SearchPlaceTableViewCell.cellIdentifier, cellType: SearchPlaceTableViewCell.self))) { (row, data, cell) in
                cell.setData(data: data)
        }
        .disposed(by: disposeBag)
        
        viewModel.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        viewModel.selectedSearchCell
            .drive(onNext: { [weak self] title in
                guard let strongSelf = self else { return }
                self?.showAlertController(message: title, from: strongSelf)
            })
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(onNext: { [weak self] message in
                guard let strongSelf = self else { return }
                self?.showAlertController(message: message, from: strongSelf)
            })
            .disposed(by: disposeBag)
    }
    
    private func initViewModel() {
        guard let coordinate = coordinate else { return }
        viewModel = SearchPlaceViewModel(coordinate: coordinate, initQuery: "")
    }
    
    func showAlertController(message: String, from: UIViewController) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        from.present(alertController, animated: true, completion: nil)
    }
}
