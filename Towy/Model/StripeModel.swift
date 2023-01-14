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
    let data: StripeData?
}


struct StripeData : Codable {
    let user_id : AnyCodableValue?
    let email : AnyCodableValue?
    let mobile_no : AnyCodableValue?
    let fcm_token : AnyCodableValue?
    let user_type : AnyCodableValue?
    let is_verified : AnyCodableValue?
    let referral_code : AnyCodableValue?
    let steps : AnyCodableValue?
    let provider : AnyCodableValue?
    let image : AnyCodableValue?
    let first_name : AnyCodableValue?
    let last_name : AnyCodableValue?
    let wallet_balance : AnyCodableValue?
    let rating : AnyCodableValue?
    let stripe_customer_id : AnyCodableValue?
    let card_number : AnyCodableValue?

    enum CodingKeys: String, CodingKey {

        case user_id = "user_id"
        case email = "email"
        case mobile_no = "mobile_no"
        case fcm_token = "fcm_token"
        case user_type = "user_type"
        case is_verified = "is_verified"
        case referral_code = "referral_code"
        case steps = "steps"
        case provider = "provider"
        case image = "image"
        case first_name = "first_name"
        case last_name = "last_name"
        case wallet_balance = "wallet_balance"
        case rating = "rating"
        case stripe_customer_id = "stripe_customer_id"
        case card_number = "card_number"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .user_id)
        email = try values.decodeIfPresent(AnyCodableValue.self, forKey: .email)
        mobile_no = try values.decodeIfPresent(AnyCodableValue.self, forKey: .mobile_no)
        fcm_token = try values.decodeIfPresent(AnyCodableValue.self, forKey: .fcm_token)
        user_type = try values.decodeIfPresent(AnyCodableValue.self, forKey: .user_type)
        is_verified = try values.decodeIfPresent(AnyCodableValue.self, forKey: .is_verified)
        referral_code = try values.decodeIfPresent(AnyCodableValue.self, forKey: .referral_code)
        steps = try values.decodeIfPresent(AnyCodableValue.self, forKey: .steps)
        provider = try values.decodeIfPresent(AnyCodableValue.self, forKey: .provider)
        image = try values.decodeIfPresent(AnyCodableValue.self, forKey: .image)
        first_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .last_name)
        wallet_balance = try values.decodeIfPresent(AnyCodableValue.self, forKey: .wallet_balance)
        rating = try values.decodeIfPresent(AnyCodableValue.self, forKey: .rating)
        stripe_customer_id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .stripe_customer_id)
        card_number = try values.decodeIfPresent(AnyCodableValue.self, forKey: .card_number)
    }

}

// MARK: - Encode/decode helpers
/*
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
*/
