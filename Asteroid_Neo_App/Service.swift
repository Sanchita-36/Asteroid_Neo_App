//
//  Service.swift
//  Asteroid_Neo_App
//
//  Created by Mac on 07/07/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation

//protocol callNeoAPIProtocol {
//    func fetchNeoDetails()
//}

class NeoService {
    static let neoInstance: NeoService = NeoService()
    //  var delegateNeo: callNeoAPIProtocol!
    
    func fetchNeoAPI(startDate: String, endDate: String, api_key: String) {
        let url = URL(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(startDate)&end_date=\(endDate)&detailed=true&api_key=\(api_key)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                print(httpResponse)
            }
            if let data = data{
                do {
                    //                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    //
                    //                    for (key, value) in json {
                    //                        if key == "near_earth_objects" {
                    //                            print("near_earth_objects Value: \(value)")
                    //                        }
                    //                    }
                    let neoResult = try JSONDecoder().decode(Response.self, from: data)
                    print(neoResult)
                }catch {
                    print("Error\(error)")
                }
            }
        }.resume()
    }
}


