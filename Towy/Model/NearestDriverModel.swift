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
*/

struct NearestDriverModel : Codable {
    let result : String?
    let message : String?
    let data : [Datum]?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([Datum].self, forKey: .data)
    }

}
struct Datum : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let distance : Double?
    let booking_id : String?
    let fcm_token : String?
    let latitude : Double?
    let longitude : Double?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case distance = "distance"
        case booking_id = "booking_id"
        case fcm_token = "fcm_token"
        case latitude = "latitude"
        case longitude = "longitude"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        fcm_token = try values.decodeIfPresent(String.self, forKey: .fcm_token)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
    }

}
