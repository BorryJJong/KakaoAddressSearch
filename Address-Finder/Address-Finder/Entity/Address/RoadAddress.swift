//
//  RoadAddress.swift
//  Address-Finder
//
//  Created by Daye on 2021/08/01.
//

import Foundation

struct RoadAddress: Codable {
    let addressName: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
    }
}
