//
//  RelativeVelocity.swift
//  Asteroid_Neo_App
//
//  Created by Mac on 07/07/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation
struct Response: Decodable {
    let near_earth_objects: [String: [SampleDate]]
}
struct SampleDate: Decodable {
    let id: String
    let absolute_magnitude_h: Double
    let close_approach_data: [CloseApproachData]
}

struct CloseApproachData: Decodable {
    let relative_velocity: RelativeVelocity
    let miss_distance: MissDistance
}

struct RelativeVelocity: Decodable {
    let kilometers_per_hour: String
}

struct MissDistance: Decodable {
    let kilometers: String
}

