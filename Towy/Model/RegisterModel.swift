//
//  RegisterModel.swift
//  Towy
//
//  Created by Usman on 18/07/2022.
//

import Foundation


// MARK: - RegisterUser
struct RegisterUser: Codable {
    let result, message: String
    let data: RegiaterDataClass
}

// MARK: - DataClass
struct RegiaterDataClass: Codable {
    let userID: Int
    let email, mobileNo, fcmToken, userType: String
    let isVerified: Int
    let referralCode: String
    let steps: Int
    let provider, image: String?
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

