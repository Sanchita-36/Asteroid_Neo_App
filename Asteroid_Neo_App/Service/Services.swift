//
//  Service2.swift
//  Asteroid_Neo_App
//
//  Created by Mac on 10/07/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation

protocol callNeoAPIProtocol {
    func fetchNeoDetails(fastestSpeed: String, closestDistance: String, fastestSpeedAsteroidID: String, closestDistanceAsteroidID: String, avgAsteroidSize: Double, dateArray: [String], asteroidCountArray: [Int])
}
typealias JSON = [String: Any]

class NeoService {
    static let neoInstance: NeoService = NeoService()
    var delegateNeo: callNeoAPIProtocol!
    var relativeVelocityData = [RelativeVelocity]()
    var asteroid_ID: [String] = []
    var kilometer_per_hour: [String] = []
    var miss_distance_km: [String] = []
    var asteroidSize: [Double] = []
    var dateArray: [String] = []
    var asteroidCountArray: [Int] = []
    var averageSize: Double = 0.0
    var count: Int = 0
    var sum: Double = 0.0
    
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
                    let data = try JSONDecoder().decode(Response.self, from: data)
                    for dateArray in data.near_earth_objects {
                        self.dateArray.append(dateArray.key)
                        self.count = 0
                        for item in dateArray.value {
                            self.asteroid_ID.append(item.id)
                            self.asteroidSize.append(item.absolute_magnitude_h)
                            self.kilometer_per_hour.append(item.close_approach_data[0].relative_velocity.kilometers_per_hour)
                            self.miss_distance_km.append(item.close_approach_data[0].miss_distance.kilometers)
                            self.count = self.count + 1
                        }
                        self.asteroidCountArray.append(self.count)
                    }
                    
                    for val in self.asteroidSize{
                        self.sum = self.sum + val
                    }
                    self.averageSize = Double(self.sum) / Double(self.count)
                    
                    let indexOfSpeed = self.kilometer_per_hour.firstIndex(of: self.kilometer_per_hour.min()!)
                    let asteroidID_indexOfSpeed = self.asteroid_ID[indexOfSpeed!]
                    
                    let indexOfDistance = self.miss_distance_km.firstIndex(of: self.miss_distance_km.min()!)
                    let asteroidID_indexOfDistance = self.asteroid_ID[indexOfDistance!]
                    
                    DispatchQueue.main.async {
                        self.delegateNeo.fetchNeoDetails(fastestSpeed: self.kilometer_per_hour.min()!, closestDistance: self.miss_distance_km.min()!, fastestSpeedAsteroidID: asteroidID_indexOfSpeed, closestDistanceAsteroidID: asteroidID_indexOfDistance, avgAsteroidSize: self.averageSize, dateArray: self.dateArray, asteroidCountArray: self.asteroidCountArray)
                    }
                }catch {
                    print("Error\(error)")
                }
            }
        }.resume()
    }
}
