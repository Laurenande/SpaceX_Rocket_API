//
//  ModelJSON.swift
//  InfoRocketSpaceX
//
//  Created by Егор Куракин on 14.04.2022.
//

import Foundation

typealias Rocket = [RocketInf]
// MARK: - RocketInf
struct RocketInf: Codable {
    let height, diameter: Diameter?
    let mass: Mass?
    let first_stage: FirstStage?
    let second_stage: SecondStage?
    let payload_weights: [PayloadWeight]?
    let flickr_images: [String]?
    let name, type: String?
    let stages,cost_per_launch: Int?
    let first_flight, country, company: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case first_stage
        case second_stage
        case payload_weights
        case flickr_images
        case name, type, stages
        case cost_per_launch
        case first_flight
        case country, company
        case id
    }
}

// MARK: - Diameter
struct Diameter: Codable {
    let meters, feet: Double?
}

// MARK: - Thrust
struct Thrust: Codable {
    let kN, lbf: Int?
}

// MARK: - FirstStage
struct FirstStage: Codable {
    let thrustSeaLevel, thrust_vacuum: Thrust?
    let engines: Int?
    let fuel_amount_tons, burn_time_sec: Double?

    enum CodingKeys: String, CodingKey {
        case thrustSeaLevel
        case thrust_vacuum
        case engines
        case fuel_amount_tons
        case burn_time_sec
    }
}

// MARK: - Mass
struct Mass: Codable {
    let kg, lb: Int?
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let id, name: String?
    let kg, lb: Int?
}

// MARK: - SecondStage
struct SecondStage: Codable {
    let engines: Int?
    let fuel_amount_tons, burn_time_sec: Double?
    enum CodingKeys: String, CodingKey {
        case engines
        case fuel_amount_tons
        case burn_time_sec
    }
}
// MARK: - Launch
struct Launch: Decodable{
    var name : String?
    var rocket: String?
    var date_local: String?
    var success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case rocket = "rocket"
        case date_local = "date_local"
        case success = "success"
    }
}



