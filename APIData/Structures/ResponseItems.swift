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

// MARK: - Items
struct Items: Codable {
    let totalCount: Int
    let pagingSettings: PagingSettings
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case pagingSettings = "PagingSettings"
        case items = "Items"
    }
}

// MARK: - PagingSettings
struct PagingSettings: Codable {
    let skip: Int
    let take: Int
    enum CodingKeys: String, CodingKey {
        case skip = "Skip"
        case take = "Take"
    }
}
//MARK: -Item
struct Item: Codable
{
    let id: String
    let sku: String
    let name: String
    let description: String
    let inventoryPolicy: String
    let url: String?
    var catalog: Catalog?
    let price: Int
    let originalPrice: Int
    let weight: Double?
    let addedToWishListCount: Int?
    let thumbnail : Thumbnail
    let pictures : Pictures?
    let displayPicture : DisplayPictures?
    let materials : Materials
    let relatedCatlogItems : RelatedCatlogItems?
    let attributes : Attributes?
    let tags : Tags?
    let stores : Stores?
    
    let availableInStore: Bool
    let isVariantDisplayPictureAvailable: Bool?
    let hasTryOnPicture: Bool

    enum CodingKeys: String, CodingKey
    {
        case id = "Id"
        case sku = "SKU"
        case name = "Name"
        case description = "Description"
        case catalog = "Catalog"
        case price = "Price"
        case originalPrice = "OriginalPrice"
        case weight = "Weight"
        case addedToWishListCount = "AddedToWishListCount"
        case thumbnail = "Thumbnail"
        case pictures = "Pictures"
        case displayPicture =  "DisplayPictures"
        case materials = "Materials"
        case relatedCatlogItems = "RelatedCatalogItems"
        case attributes = "Attributes"
        case tags = "Tags"
        case stores = "Stores"
        case availableInStore = "AvailableInStore"
        case isVariantDisplayPictureAvailable = "IsVariantDisplayPictureAvailable"
        case inventoryPolicy = "InventoryPolicy"
        case url = "Url"
        case hasTryOnPicture = "HasTryOnPicture"
        }
    }
struct Catalog: Codable {
}
struct Thumbnail: Codable {
    var extraSmall : String
    var small: String
    var medium: String
    enum CodingKeys: String, CodingKey
    {
        case extraSmall = "ExtraSmall"
        case small = "Small"
        case medium = "Medium"
    }
}
struct Pictures: Codable {
}
struct DisplayPictures: Codable {
}
struct Materials: Codable {
}
struct RelatedCatlogItems: Codable {
}
struct Attributes: Codable {
}
struct Tags: Codable {
}
struct Stores: Codable {
}


