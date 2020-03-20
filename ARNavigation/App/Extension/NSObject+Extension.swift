//
//  NSObject+Extension.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/07.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import Foundation

extension NSObject {
    
    var stringFromClass: String {
        return NSStringFromClass(type(of: self))
            .components(separatedBy: ".")
            .last ?? ""
    }
    
    static var stringFromClass: String {
        return NSStringFromClass(self)
            .components(separatedBy: ".")
            .last ?? ""
    }
}
