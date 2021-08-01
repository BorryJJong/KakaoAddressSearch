//
//  AddressStruct.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/29.
//

import Foundation

struct Address: Codable {
    let addressName: String
    
    enum CodingKeys : String, CodingKey {
        case addressName = "address_name"
    }
}
