//
//  APIUtilities.swift
//  APIData
//
//  Created by Amey Ranade on 29/04/21.
//

import Foundation
enum RequestURL: String{
    case login = "https://www.pngadgil1832.com/rest/api/v1/authenticateAnonymousUser"
    case products = "https://www.pngadgil1832.com/rest/api/v1/search/60fe6317-f9fd-4356-bffb-a294029f2654/facetedSearchV2?take=10&skip=0&categorytype=Catalog"
}

class ApiUtilities
 {
    var responseData = [ResponseItems]()
    func postApiData<T:Codable>(requestUrl : URL, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session =  URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                do{
                    let loginDetails = try  JSONDecoder().decode(LoginDetails.self, from : jsonData)
                    _=completionHandler(loginDetails as! T)
                }catch{
                    print(error)
                }
            }
            
        }.resume()
    }

    func postBodyApiData<T:Codable>(requestUrl : URL,requestBody: Data, token : String, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        
        let decoder = JSONDecoder()
        let tokenVlaue = token
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tokenVlaue, forHTTPHeaderField: "Authorization")
        let session =  URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
        if let jsonData = data {
            do{
                let productData = try  decoder.decode(ResponseItems.self, from : jsonData)
                _=completionHandler(productData as! T)
                self.responseData = [productData]
             
            }catch{
                print(error)
            }
        }
    }.resume()
}
}
