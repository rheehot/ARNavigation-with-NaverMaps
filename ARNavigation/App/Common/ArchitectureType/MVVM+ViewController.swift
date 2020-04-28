//
//  MVVM+ViewController.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/02.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit
import RxSwift

class ViewController<ViewBindable>: UIViewController {
    var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func bind(_ viewModel: ViewBindable) {}
    
    func attribute() {}
    
    func initialize() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)가 구현되어 있지 않습니다.")
    }
    
}
