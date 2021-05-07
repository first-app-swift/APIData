//
//  Items.swift
//  APIData
//
//  Created by Amey Ranade on 05/05/21.
//

import Foundation

struct Items: Codable{
    let totalCount: Int?
    let pagingSettings: PagingSettings?
    let items: [Product]

    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case pagingSettings = "PagingSettings"
        case items = "Items"
    }
}
