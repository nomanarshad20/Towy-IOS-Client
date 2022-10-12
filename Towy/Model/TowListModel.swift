//
//  TowListModel.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//

import Foundation
// MARK: - TowListModel
/*
struct TowListModel: Codable {
    let result, message: String
    let data: [TowDatum]
}

// MARK: - Datum
struct TowDatum: Codable {
    let minFare, perKMRate, perMinRate, taxRate: Int
    let waitingPricePerMin, vehicleTypeID, totalDistance, peakFactorApplied: Int
    let peakFactorRate: String?
    let estimatedFare: Int
    let name: String
    let distanceInMinutes:String?
    enum CodingKeys: String, CodingKey {
        case minFare = "min_fare"
        case perKMRate = "per_km_rate"
        case perMinRate = "per_min_rate"
        case taxRate = "tax_rate"
        case waitingPricePerMin = "waiting_price_per_min"
        case vehicleTypeID = "vehicle_type_id"
        case totalDistance = "total_distance"
        case peakFactorApplied = "peak_factor_applied"
        case peakFactorRate = "peak_factor_rate"
        case estimatedFare = "estimated_fare"
        case distanceInMinutes = "driver_reach_time_in_minutes"
        case name
    }
}
*/

/*
// MARK: - SaveOrderModel
struct TowListModel: Codable {
    let result, message: String
    let data: [TowDatum]
}

// MARK: - Datum
struct TowDatum: Codable {
    let minFare, perKMRate, perMinRate, taxRate: Int?
    let waitingPricePerMin, vehicleTypeID: Int?
    let totalDistance: Double?
    let peakFactorApplied: Int?
    let peakFactorRate, driverReachTimeInMinutes: String?
    let driverID, estimatedFare: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case minFare = "min_fare"
        case perKMRate = "per_km_rate"
        case perMinRate = "per_min_rate"
        case taxRate = "tax_rate"
        case waitingPricePerMin = "waiting_price_per_min"
        case vehicleTypeID = "vehicle_type_id"
        case totalDistance = "total_distance"
        case peakFactorApplied = "peak_factor_applied"
        case peakFactorRate = "peak_factor_rate"
        case driverReachTimeInMinutes = "driver_reach_time_in_minutes"
        case driverID = "driver_id"
        case estimatedFare = "estimated_fare"
        case name
    }
}
// MARK: - Encode/decode helpers
/*
class TowJSONNull: Codable, Hashable {
 

    public static func == (lhs: TowJSONNull, rhs: TowJSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
*/
*/


struct TowListModel : Codable {
    let result : String?
    let message : String?
    let data : [TowDatum]?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([TowDatum].self, forKey: .data)
    }

}

struct TowDatum : Codable {
    let min_fare : Int?
    let per_km_rate : Int?
    let per_min_rate : Int?
    let tax_rate : Int?
    let waiting_price_per_min : Int?
    let vehicle_type_id : Int?
    let total_distance : Int?
    let peak_factor_applied : Int?
    let peak_factor_rate : String?
    let driver_reach_time_in_minutes : Int?
    let driver_id : Int?
    let estimated_fare : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case min_fare = "min_fare"
        case per_km_rate = "per_km_rate"
        case per_min_rate = "per_min_rate"
        case tax_rate = "tax_rate"
        case waiting_price_per_min = "waiting_price_per_min"
        case vehicle_type_id = "vehicle_type_id"
        case total_distance = "total_distance"
        case peak_factor_applied = "peak_factor_applied"
        case peak_factor_rate = "peak_factor_rate"
        case driver_reach_time_in_minutes = "driver_reach_time_in_minutes"
        case driver_id = "driver_id"
        case estimated_fare = "estimated_fare"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        min_fare = try values.decodeIfPresent(Int.self, forKey: .min_fare)
        per_km_rate = try values.decodeIfPresent(Int.self, forKey: .per_km_rate)
        per_min_rate = try values.decodeIfPresent(Int.self, forKey: .per_min_rate)
        tax_rate = try values.decodeIfPresent(Int.self, forKey: .tax_rate)
        waiting_price_per_min = try values.decodeIfPresent(Int.self, forKey: .waiting_price_per_min)
        vehicle_type_id = try values.decodeIfPresent(Int.self, forKey: .vehicle_type_id)
        total_distance = try values.decodeIfPresent(Int.self, forKey: .total_distance)
        peak_factor_applied = try values.decodeIfPresent(Int.self, forKey: .peak_factor_applied)
        peak_factor_rate = try values.decodeIfPresent(String.self, forKey: .peak_factor_rate)
        driver_reach_time_in_minutes = try values.decodeIfPresent(Int.self, forKey: .driver_reach_time_in_minutes)
        driver_id = try values.decodeIfPresent(Int.self, forKey: .driver_id)
        estimated_fare = try values.decodeIfPresent(Int.self, forKey: .estimated_fare)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
