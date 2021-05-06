//
//  PagingSettings.swift
//  APIData
//
//  Created by Amey Ranade on 05/05/21.
//

import Foundation

struct PagingSettings: Codable {
    let skip: Int
    let take: Int
    enum CodingKeys: String, CodingKey {
        case skip = "Skip"
        case take = "Take"
    }
}
