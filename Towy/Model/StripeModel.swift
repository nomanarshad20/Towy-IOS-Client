//
//  StripeModel.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//

import Foundation


// MARK: - StripeModel
struct StripeModel: Codable {
    let result, message: String
    let data: JSONNull?
}

// MARK: - Encode/decode helpers

class StripeJSONNull: Codable, Hashable {

    public static func == (lhs: StripeJSONNull, rhs: StripeJSONNull) -> Bool {
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
