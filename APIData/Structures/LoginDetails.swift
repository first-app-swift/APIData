//
//  LoginDetails.swift
//  APIData
//
//  Created by Amey Ranade on 28/04/21.
//

import Foundation

struct LoginDetails : Codable{
    var id: String
    var accessToken : String
    var firstName : String
    var refreshToken: String
    
    enum  CodingKeys : String, CodingKey {
        case id = "Id"
        case accessToken = "AccessToken"
        case firstName = "FirstName"
        case refreshToken = "RefreshToken"
    }
    
}


