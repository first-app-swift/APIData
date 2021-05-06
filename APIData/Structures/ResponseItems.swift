//
//  ResponseItems.swift
//  APIData
//
//  Created by Amey Ranade on 30/04/21.
//

import Foundation

struct ResponseItems: Codable {
    let items: Items

    enum CodingKeys: String, CodingKey {
        case items = "Items"
    }
}
