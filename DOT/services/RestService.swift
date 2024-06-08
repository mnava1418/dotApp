//
//  RestService.swift
//  DOT
//
//  Created by Martin Nava on 15/05/24.
//

import Foundation

struct RestService {
    public static func post(url: URL, body: Data, token: String?, completion: @escaping(Int, String?, [String: Any]? ) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            request.addValue(token, forHTTPHeaderField: "token")
        }
        
        request.httpBody = body
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(500, error.localizedDescription, nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(500, "Error inesperado. Intenta nuevamente.", nil)
                return
            }
            
            let statusCode = httpResponse.statusCode
            var jsonResponse: [String: Any]?
            
            if let data = data {
                do {
                    jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    print("Unable to parse data")
                }
            }
            
            if(statusCode == 200) {
                completion(statusCode, nil, jsonResponse)
            } else  {
                let errorMessage = parseErrorData(data: jsonResponse)
                completion(statusCode, errorMessage, nil)
            }
        }
        
        task.resume()
    }
    
    private static func parseErrorData (data: [String: Any]?) -> String{
        if let data = data, let errorMessage = data["error"] as? String {
            return errorMessage
        } else {
            return "Error inesperado. Intenta nuevamente."
        }
    }
}
