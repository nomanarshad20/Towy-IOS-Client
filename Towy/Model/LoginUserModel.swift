//
//  LoginUserModel.swift
//  Towy
//
//  Created by Usman on 12/08/2022.
//

import Foundation


// MARK: - UserLogin
/*
struct UserLogin: Codable {
    let result, message: String?
    let data: LoginDataClass
}

// MARK: - DataClass
struct LoginDataClass: Codable {
    let userID: Int?
    let email, mobileNo, fcmToken: String?
    let userType, isVerified: Int?
    let referralCode: String?
    let steps: Int?
    let provider : String? = nil
    let image: String? = nil
    let firstName, lastName: String?
    let walletBalance, rating: Int?
    let accessToken: String?

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
*/

struct UserLogin : Codable {
    let result : String?
    let message : String?
    let data : LoginDataClass?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(LoginDataClass.self, forKey: .data)
    }

}
struct LoginDataClass : Codable {
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
    let access_token : AnyCodableValue?

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
        case access_token = "access_token"
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
        access_token = try values.decodeIfPresent(AnyCodableValue.self, forKey: .access_token)
    }

}
