//
//  UIView+Extension.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/07.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit

extension UIView {
    
    // UIView instantiateView
    static func instnatiate(fromXib name: String) -> UIView? {
        return UINib(nibName: name, bundle: nil)
            .instantiate(withOwner: nil, options: nil)
            .first as? UIView
    }
}
