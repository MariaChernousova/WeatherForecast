//
//  Location.swift
//  hw14
//
//  Created by Chernousova Maria on 04.11.2021.
//

import Foundation

struct Location: Codable {
    var name: String
    var type: String
    var id: Int
    var coordinates: String
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case type = "location_type"
        case id = "woeid"
        case coordinates = "latt_long"
    }
}
