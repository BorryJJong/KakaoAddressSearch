//
//  AddressStruct.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/29.
//

import Foundation

struct APIResponse: Codable{
    let documents: [Documents]
}

struct Documents: Codable{
    let address_name: String
    let address_type: String
    let address: Address
    let road_address: RoadAddress
}

struct Address: Codable{
    let address_name: String
}

struct RoadAddress: Codable {
    let address_name: String
}
