// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let socialUser = try? newJSONDecoder().decode(SocialUser.self, from: jsonData)

import Foundation

// MARK: - SocialUser
struct SocialUser: Codable {
    let result, message: String
    let data: socialDataClass
}

// MARK: - DataClass
struct socialDataClass: Codable {
    let userID: Int
    let email: String?
    let mobileNo: String?
    let fcmToken: String
    let userType, isVerified: Int
    let referralCode: String
    let steps: Int
    let provider: String
    let image: String?
    let firstName, lastName: String
    let walletBalance: Int
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email = "email"
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


