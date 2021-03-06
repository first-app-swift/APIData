//
//  DisplayPictures.swift
//  APIData
//
//  Created by Amey Ranade on 05/05/21.
//

import Foundation
struct DisplayPictures: Codable {
    let mediaContentType : String?
    let pictureURL : String
    let thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey
    {
        case mediaContentType = "MediaContentType"
        case pictureURL = "PictureUrl"
        case thumbnail = "Thumbnail"
       
    }
   
}
