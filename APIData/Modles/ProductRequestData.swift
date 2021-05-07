//
//  ProductRequestData.swift
//  APIData
//
//  Created by Amey Ranade on 30/04/21.
//

import Foundation

struct ProductsRequestData: Codable
{
    var order : String
    var orderBy : String
    var facetsCriteria : [String]
    
    enum Codingkeys: String , CodingKey {
        case order = "Order"
        case orderBy = "OrderBy"
        case facetsCriteria = "FacetsCriteria"
    }
}
