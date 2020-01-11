//
//  SymbolInfoView.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/01/06.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NMapsMap

@IBDesignable
class SymbolInfoView: UIView {
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!

    private let xibName = "SymbolInfoView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        guard let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?
            .first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
}
