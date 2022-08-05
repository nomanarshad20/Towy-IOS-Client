// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let socialUser = try? newJSONDecoder().decode(SocialUser.self, from: jsonData)

import Foundation
import SwiftyJSON

// MARK: - SocialUser
struct SocialUser : Codable{
    
    let result, message: String
    let data: socialDataClass
    
    struct socialDataClass: Codable {
        let userID: String!
        let email: String!
        let mobileNo: String!
        let fcmToken: String!
        let userType:Int!
        let isVerified: Int!
        let referralCode: String!
        //        let steps: Int!
        let provider: String!
        //        let image: String!
        let firstName, lastName: String!
        let walletBalance: Int!
        let accessToken: String!
        
        init(fromJson json: JSON!){
            userID = json["social_uid"].string
            email = json["email"].string
            mobileNo = json["mobile_no"].string
            fcmToken = json["fcm_token"].string
            userType = json["user_type"].int
            isVerified = json["is_verified"].int
            provider = json["provider"].string
            referralCode = json["referral_code"].string
            //         steps = 0
            //         provider = ""
            //         image = ""
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
            provider = aDecoder.decodeObject(forKey: "provider") as? String
            referralCode = aDecoder.decodeObject(forKey: "referral_code") as? String
            firstName = aDecoder.decodeObject(forKey: "first_name") as? String
            lastName = aDecoder.decodeObject(forKey: "last_name") as? String
            walletBalance = aDecoder.decodeObject(forKey: "wallet_balance") as? Int
            accessToken = aDecoder.decodeObject(forKey: "access_token") as? String
        }
    }
}



