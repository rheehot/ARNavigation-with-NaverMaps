//
//  Reactive+Extension.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/03/10.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}
