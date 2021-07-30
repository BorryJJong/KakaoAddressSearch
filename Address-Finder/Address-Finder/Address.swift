//
//  AddressStruct.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/29.
//

import Foundation

struct APIResponse: Codable {
    let documents: [Documents]
}

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

struct Address: Codable {
    let addressName: String
    
    enum CodingKeys : String, CodingKey {
        case addressName = "address_name"
    }
}

struct RoadAddress: Codable {
    let addressName: String
    
    enum CodingKeys : String, CodingKey {
        case addressName = "address_name"
    }
}
