//
//  RegisterModel.swift
//  Towy
//
//  Created by Usman on 18/07/2022.
//

import Foundation
import SwiftyJSON


// MARK: - RegisterUser
struct RegisterUser: Codable {
    let result, message: String
    let data: RegisterDataClass
}

// MARK: - DataClass
struct RegisterDataClass: Codable {
    let userID: String!
    let email: String!
    let mobileNo: String!
    let fcmToken: String!
    let userType:Int!
    let isVerified: Int!
    let referralCode: String!
    let firstName, lastName: String!
    let walletBalance: Int!
    let accessToken: String!
    
    init(fromJson json: JSON!){
        userID = json["user_id"].string
        email = json["email"].string
        mobileNo = json["mobile_no"].string
        fcmToken = json["fcm_token"].string
        userType = json["user_type"].int
        isVerified = json["is_verified"].int
        referralCode = json["referral_code"].string
        firstName = json["first_name"].string
        lastName = json["last_name"].string
        walletBalance = json["wallet_balance"].int
        accessToken = json["access_token"].string
    }
    
    init(coder aDecoder: NSCoder)
    {
        userID = aDecoder.decodeObject(forKey: "user_id") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        mobileNo = aDecoder.decodeObject(forKey: "mobile_no") as? String
        fcmToken = aDecoder.decodeObject(forKey: "fcm_token") as? String
        userType = aDecoder.decodeObject(forKey: "user_type") as? Int
        isVerified = aDecoder.decodeObject(forKey: "is_verified") as? Int
        referralCode = aDecoder.decodeObject(forKey: "referral_code") as? String
        firstName = aDecoder.decodeObject(forKey: "first_name") as? String
        lastName = aDecoder.decodeObject(forKey: "last_name") as? String
        walletBalance = aDecoder.decodeObject(forKey: "wallet_balance") as? Int
        accessToken = aDecoder.decodeObject(forKey: "access_token") as? String
    }
}


