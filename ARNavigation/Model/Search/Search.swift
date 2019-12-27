//
//  Search.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/12/26.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

struct Search: Codable {
    let lastBuildDate: Date?
    let total: Int?
    let start: Int?
    let display: Int?
    let item: SearchItem?
}

struct SearchItem: Codable {
    let title: String?
    let link: String?
    let category: String?
    let description: String?
    let telephone: String?
    let address: String?
    let roadAddress: String?
    let mapx: String?
    let mapy: String?
}


