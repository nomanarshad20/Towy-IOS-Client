//
//  LoginModel.swift
//  Towy
//
//  Created by Usman on 05/07/2022.
//

import Foundation
import Foundation


//{"result":"error","message":"User Not Exist. ","data":{"user_exist":false}}
// MARK: - Login
//struct LoginModel: Codable {
//    let result, message: String
//    let data: DataClass
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let userExist: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case userExist = "user_exist"
//    }
//}


struct LoginModel : Codable {
    let result : String?
    let message : String?
    let data : DataClass?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(DataClass.self, forKey: .data)
    }

}

struct DataClass : Codable {
    let user_exist : Bool?

    enum CodingKeys: String, CodingKey {

        case user_exist = "user_exist"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_exist = try values.decodeIfPresent(Bool.self, forKey: .user_exist)
    }

}
