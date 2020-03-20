//
//  SearchPlaceTableViewCell.swift
//  ARNavigation
//
//  Created by youngjun goo on 2020/03/09.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit
import SnapKit

class SearchPlaceTableViewCell: UITableViewCell, InterfaceBuildable, BindDataShowable {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var addressLabel: UILabel?
    
    static var reusableIdentifier: String { return String(describing: self) }
    static var cellIdentifier: String { return self.stringFromClass }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: PlaceInfo) {
        titleLabel?.text = "\(data.name ?? "")"
        addressLabel?.text = "주소:\(data.roadAddress ?? "")"
    }
    
    func attribute() {
        titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel?.textColor = .black
        
        addressLabel?.font = .systemFont(ofSize: 10, weight: .light)
        addressLabel?.textColor = .gray
        addressLabel?.numberOfLines = 0
    }
}

