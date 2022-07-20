//
//  SocialUserModel.swift
//  Towy
//
//  Created by Usman on 18/07/2022.
//

import Foundation


// MARK: - SocialUser
struct SocialUser: Codable {
    let result, message: String
    let data: socialDataClass
}

// MARK: - DataClass
struct socialDataClass: Codable {
    let userID: Int
    let email: String
    let mobileNo: JSONNull?
    let fcmToken, userType: String
    let isVerified: Int
    let referralCode: String
    let steps: Int
    let provider: String
    let image: socialJSONNull?
    let firstName, lastName: String
    let walletBalance: Int
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case mobileNo = "mobile_no"
        case fcmToken = "fcm_token"
        case userType = "user_type"
        case isVerified = "is_verified"
        case referralCode = "referral_code"
        case steps, provider, image
        case firstName = "first_name"
        case lastName = "last_name"
        case walletBalance = "wallet_balance"
        case accessToken = "access_token"
    }
}

// MARK: - Encode/decode helpers

class socialJSONNull: Codable, Hashable {

    public static func == (lhs: socialJSONNull, rhs: socialJSONNull) -> Bool {
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
