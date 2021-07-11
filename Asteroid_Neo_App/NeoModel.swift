////
////  NeoModel.swift
////  Asteroid_Neo_App
////
////  Created by Mac on 08/07/21.
////  Copyright © 2021 Sanchita. All rights reserved.
////
//
//import Foundation
//
////struct NeoData {
////    var near_earth_objects: JSON = JSON()
////
////    init(json: JSON) {
////        self.near_earth_objects = json["near_earth_objects"] as? JSON ?? [:]
////    }
////}
//
//struct NearEarthObjects {
//    let near_earth_objects: [CloseApproachData]
//    
//    init?(json: JSON) {
//        guard let nearEarthObjects = json["near_earth_objects"] as? JSON else { return nil }
//        guard let nearEarthArray = nearEarthObjects["close_approach_data"] as? [JSON] else { return nil }
//        let itemObjects = nearEarthArray.map({ CloseApproachData(json: $0)! })
//        self.near_earth_objects = itemObjects
//    }
//}
//
////struct DateObject {
////    let dateObject: [CloseApproachData]
////
////    init?(json: JSON) {
////        guard let closeApproachDataJSON = json["close_approach_data"] as? [JSON] else { return nil }
////        let dateArray = closeApproachDataJSON.map({ CloseApproachData(json: $0)! })
////        self.dateObject = dateArray
////    }
////}
//
//struct CloseApproachData {
//    
//    let close_approach_data: [RelativeVelocity]
//    
//    init?(json: JSON) {
//        guard let relativeVelocityJSON = json["relative_velocity"] as? [JSON] else { return nil }
//        let close_approach_data = relativeVelocityJSON.map({ RelativeVelocity(json: $0)! })
//        self.close_approach_data = close_approach_data
//    }
//}
//
//struct RelativeVelocity {
//    let kilometers_per_hour: String
//    init?(json: JSON) {
//        guard let kilometers_per_hour = json["kilometers_per_hour"] as? String
//            else { return nil }
//        
//        self.kilometers_per_hour = kilometers_per_hour
//    }
//}
