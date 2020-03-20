//
//  ViewModelType.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/27.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
