//
//  TowListModel.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//

import Foundation
// MARK: - TowListModel
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
