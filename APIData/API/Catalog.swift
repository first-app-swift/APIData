//
//  Catalog.swift
//  APIData
//
//  Created by Amey Ranade on 05/05/21.
//

import Foundation

struct Catalog: Codable {
    var extraSmall : String?
    var small: String?
    var medium: String?
    enum CodingKeys: String, CodingKey
    {
        case extraSmall = "ExtraSmall"
        case small = "Small"
        case medium = "Medium"
    }
}
