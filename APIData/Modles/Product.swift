//
//  Product.swift
//  APIData
//
//  Created by Amey Ranade on 05/05/21.
//

import Foundation

struct Product: Codable {
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
    let displayPicture : [DisplayPictures]?
    let materials : Materials
    let relatedCatlogItems : RelatedCatlogItems?
    let attributes : Attributes?
    let tags : Tags?
    let stores : Stores?
    
    let availableInStore: Bool
    let isVariantDisplayPictureAvailable: Bool?
    let hasTryOnPicture: Bool
    var hasFavorite: Bool?

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
        case hasFavorite = "hasFavorite"
        }
    }
