//
//  APIDataController.swift
//  APIData
//
//  Created by Amey Ranade on 28/04/21.
//

import Foundation

class ApiUtilities
 {
    func postApiData(requestUrl : URL, completionHandler:@escaping(_ result: ApiUtilities)-> Void)
    {
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session =  URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                do{
                    let loginResponse = try  JSONDecoder().decode(LoginDetails.self, from : jsonData)
                    print(loginResponse.accessToken)
                }catch{
                    print(error)
                }
            }
            
        }.resume()
    }
    
}



//requestBody: Data,
func getApiData(requestUrl : URL,requestBody: Data, completionHandler:@escaping(_ result: ApiUtilities)-> Void)
    {
            
        
    }
