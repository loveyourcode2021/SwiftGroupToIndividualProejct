//
//  Networker.swift
//  StreetFoodApp
//
//   Created by Dong Yeol Lee on 2021-03-22.
//

import Foundation
enum NetworkerError: Error {
    case badResponse
    case badStatusCode(Int)
    case badData
}


class Networker {
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func getFoodTruck(completion: @escaping ([String: FoodTruckAPI]?, Error?) -> Void) {
        
        
        let searchURL = "http://data.streetfoodapp.com/1.1/schedule/vancouver/"
        guard let url = URL(string: searchURL) else {
            print("url is not URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, NetworkerError.badResponse)
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, NetworkerError.badData)
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ApiFoodTruck.self, from: data)
                DispatchQueue.main.async {
                    print("success")
                    completion(result.vendors, nil)
                }
                
                
            } catch let error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
        }
        task.resume()
    }
}
