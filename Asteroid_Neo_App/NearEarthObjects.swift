//
//  RelativeVelocity.swift
//  Asteroid_Neo_App
//
//  Created by Mac on 07/07/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation

struct Response: Codable {
    let nearEarthObjects: [String: [NearEarthObject]]

    enum CodingKeys: String, CodingKey {
        case nearEarthObjects = "near_earth_objects"
    }
}

struct NearEarthObject: Codable {
    let closeApproachData: [CloseApproachDatum]

    enum CodingKeys: String, CodingKey {
        case closeApproachData = "close_approach_data"
    }
}

struct CloseApproachDatum: Codable {
    let relativeVelocity: RelativeVelocity

    enum CodingKeys: String, CodingKey {
        case relativeVelocity = "relative_velocity"
    }
}

struct RelativeVelocity: Codable {
    let kilometersPerHour: String

    enum CodingKeys: String, CodingKey {
        case kilometersPerHour = "kilometers_per_hour"
    }
}
