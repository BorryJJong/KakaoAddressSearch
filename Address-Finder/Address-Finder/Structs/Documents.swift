//
//  Documents.swift
//  Address-Finder
//
//  Created by Daye on 2021/08/01.
//

import Foundation

struct Documents: Codable {
    let addressName: String
    let addressType: String
    let address: Address?
    let roadAddress: RoadAddress?
    
    enum CodingKeys : String, CodingKey {
        case addressName = "address_name"
        case addressType = "address_type"
        case address
        case roadAddress = "road_address"
    }
}
