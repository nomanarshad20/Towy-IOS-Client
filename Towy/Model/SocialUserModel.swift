// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let socialUser = try? newJSONDecoder().decode(SocialUser.self, from: jsonData)

import Foundation
import SwiftyJSON

// MARK: - SocialUser
/*
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



*/
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let socialUser = try? newJSONDecoder().decode(SocialUser.self, from: jsonData)


// MARK: - SocialUser
/*
struct SocialUser: Codable {
    let result, message: String
    let data: SocialDataClass
}

// MARK: - DataClass
struct SocialDataClass: Codable {
    let userID: Int
    let email: String
    let mobileNo: String? = nil
    let fcmToken: String
    let userType, isVerified: Int
    let referralCode: String
    let steps: Int
    let provider: String
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

*/

struct SocialUser: Codable{
    let result : String?
    let message : String?
    let data : SocialDataClass?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(SocialDataClass.self, forKey: .data)
    }

}
struct SocialDataClass: Codable {
    let user_id : AnyCodableValue?
    let email : AnyCodableValue?
    let mobile_no : AnyCodableValue?
    let fcm_token : AnyCodableValue?
//    let user_type : Int?
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
        case access_token = "access_token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        /*
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        fcm_token = try values.decodeIfPresent(String.self, forKey: .fcm_token)
        user_type = try values.decodeIfPresent(AnyCodableValue.self, forKey: .user_type)
        /*
        do {
            user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
        }
        catch DecodingError.typeMismatch{
            let value = try values.decode(String.self, forKey: .user_type)
            user_type = Int(value);
        }
        */
        
        is_verified = try values.decodeIfPresent(Int.self, forKey: .is_verified)
        referral_code = try values.decodeIfPresent(String.self, forKey: .referral_code)
        steps = try values.decodeIfPresent(Int.self, forKey: .steps)
        provider = try values.decodeIfPresent(String.self, forKey: .provider)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        wallet_balance = try values.decodeIfPresent(Int.self, forKey: .wallet_balance)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        stripe_customer_id = try values.decodeIfPresent(String.self, forKey: .stripe_customer_id)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
        */
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
        access_token = try values.decodeIfPresent(AnyCodableValue.self, forKey: .access_token)
    }

}


enum MultiType: Codable {

    case string(String)
    case int(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = .int(try container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            self = .string(try container.decode(String.self))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        }
    }
}


