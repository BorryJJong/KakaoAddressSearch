//
//  Documents.swift
//  Address-Finder
//
//  Created by Daye on 2021/08/01.
//

import Foundation

struct Documents: Codable {
  let placeName: String
  let addressName: String
  let roadAddressName: String
  let longtitude: String
  let latitude: String
  
  enum CodingKeys: String, CodingKey {
    case placeName = "place_name"
    case addressName = "address_name"
    case roadAddressName = "road_address_name"
    case longtitude = "x"
    case latitude = "y"
  }
}
