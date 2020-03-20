//
//  TableViewType.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/03/09.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import Foundation

protocol InterfaceBuildable {
    static var reusableIdentifier: String { get }
    static var cellIdentifier: String { get }
}
// biniding 된 ViewModel의 데이터를 보여 준다
protocol BindDataShowable {
    associatedtype BindData
    
    func setData(data: BindData)
}

