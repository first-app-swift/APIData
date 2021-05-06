//
//  ProductDetails.swift
//  APIData
//
//  Created by Amey Ranade on 04/05/21.
//

import Foundation

class ProductDetails
{
    func productDetails<T:Codable>(id: String, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
        {
        let url = RequestURL.productDetails.rawValue
        let newURL = url + id
        let decoder = JSONDecoder()
        let token = loginData?.accessToken
        guard let requestURL = URL(string: newURL) else {
            print("NO data found")
            return
            
        }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(token!, forHTTPHeaderField: "Authorization")
            let session =  URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let jsonData = data {
                    do{
                        let responseItem = try decoder.decode(Product.self, from: jsonData)
                        _=completionHandler(responseItem as! T)
                    }catch{
                        print(error)
                    }
                }
                
            }.resume()
        }
}
