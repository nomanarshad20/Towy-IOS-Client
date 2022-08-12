//
//  LoginUserModel.swift
//  Towy
//
//  Created by Usman on 12/08/2022.
//

import Foundation


// MARK: - UserLogin
struct UserLogin: Codable {
    let result, message: String
    let data: LoginDataClass
}

// MARK: - DataClass
struct LoginDataClass: Codable {
    let userID: Int
    let email, mobileNo, fcmToken: String
    let userType, isVerified: Int
    let referralCode: String
    let steps: Int
    let provider : String? = nil
    let image: String? = nil
    let firstName, lastName: String
    let walletBalance, rating: Int
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
        case rating
        case accessToken = "access_token"
    }
}


