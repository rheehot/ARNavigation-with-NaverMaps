//
//  NMViewController.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/24.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol NMViewBindable {
    // input
    var viewWillAppear: PublishSubject<Void> { get }
    // output
}

class NMViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
