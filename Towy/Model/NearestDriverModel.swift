//
//  NearestDriverModel.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//

import Foundation
/*
struct NearestDriverModel: Codable {
    let result, message: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let firstName, lastName: String
    let distance: Double
    let bookingID, fcmToken: String
    let latitude, longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case distance
        case bookingID = "booking_id"
        case fcmToken = "fcm_token"
        case latitude, longitude
    }
}
*/
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let nearestDriverModel = try? newJSONDecoder().decode(NearestDriverModel.self, from: jsonData)

import Foundation

// MARK: - NearestDriverModel
struct NearestDriverModel: Codable {
    let result, message: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let firstName, lastName: String
    let distance: Double
    let bookingID: String? 
    let fcmToken: String?
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case distance
        case bookingID = "booking_id"
        case fcmToken = "fcm_token"
        case latitude, longitude
    }
}

