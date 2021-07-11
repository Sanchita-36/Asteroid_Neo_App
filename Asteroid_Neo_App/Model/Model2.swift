//
//  Model2.swift
//  Asteroid_Neo_App
//
//  Created by Mac on 10/07/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation

struct Response1: Decodable {
    let near_earth_objects: [String: [SampleDate1]]//NearEarthObjects
}

//struct NearEarthObjects: Decodable {
//    var SampleDate: [SampleDate]
//    enum CodingKeys: String, CodingKey {
//        case SampleDate  = "2021-07-10"
//    }
//}

struct SampleDate1: Decodable {
    let id: String
    let absolute_magnitude_h: Double
    let close_approach_data: [CloseApproachData1]
}

struct CloseApproachData1: Decodable {
    let relative_velocity: RelativeVelocity1
    let miss_distance: MissDistance1
}

struct RelativeVelocity1: Decodable {
    let kilometers_per_hour: String
}

struct MissDistance1: Decodable {
    let kilometers: String
}

