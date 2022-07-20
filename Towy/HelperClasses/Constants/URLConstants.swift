//
//  URLConstants.swift
//  Towy
//
//  Created by Usman on 05/07/2022.
//

import Foundation
struct APPURL {

    private struct Domains {
        static let Dev = "http://3.101.101.16"
//        static let UAT = "http://test-UAT.com"
//        static let Local = "192.145.1.1"
//        static let QA = "testAddress.qa.com"
    }

    private  struct Routes {
        static let Api = "/api/"
    }

    private  static let Domain = Domains.Dev
    private  static let Route = Routes.Api
    static let BaseURL = Domain + Route

    enum services :String{
        case checkPhoneNumber = "passenger-check-phone-number"
        case passengerLogin = "passenger-login" // mobile_no,user_type,fcm_token
        case passengerRegister = "passenger-register" // mobile_no,user_type,fcm_token,first_name,email,password,last_name
        case passengerUserInfoUpdate = "passenger-user-info-update" //name
        case passengerSocialLogin = "passenger-social-login" //user_type,fcm_token,provider,social_uid
        case passengerForgetPassword = "passenger-forget-password" //mobile_no,password
        case passengerUpdatePassword = "passenger-update-password" //old_password,password
        case passengerLogout = "passenger-logout"//
    }
    
}


