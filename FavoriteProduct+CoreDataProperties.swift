//
//  FavoriteProduct+CoreDataProperties.swift
//  APIData
//
//  Created by Amey Ranade on 05/05/21.
//
//

import Foundation
import CoreData


extension FavoriteProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteProduct> {
        return NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
    }

    @NSManaged public var productId: String?

}

extension FavoriteProduct : Identifiable {

}
