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
struct LoginModel: Codable {
    let result, message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let userExist: Bool

    enum CodingKeys: String, CodingKey {
        case userExist = "user_exist"
    }
}
