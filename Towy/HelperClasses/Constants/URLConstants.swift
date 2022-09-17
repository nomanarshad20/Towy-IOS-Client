//
//  URLConstants.swift
//  Towy
//
//  Created by Usman on 05/07/2022.
//

import Foundation
struct APPURL {

    private struct Domains {
        static let Dev = "http://54.183.143.65"
        static var socketURL = "http://54.183.143.65:8081"
//        static let UAT = "http://test-UAT.com"
//        static let Local = "192.145.1.1"
//        static let QA = "testAddress.qa.com"
    }

    private  struct Routes {
        static let Api = "/api/"
    }

    static let Domain = Domains.Dev
    static let SocketUrl = Domains.socketURL

    private  static let Route = Routes.Api
    static let BaseURL = Domain + Route

    enum services :String{
        
        // MARK: - USERAUTHENTICATION_ENDPOINT

        case checkPhoneNumber = "passenger-check-phone-number"
        case passengerLogin = "passenger-login" // mobile_no,user_type,fcm_token
        case passengerRegister = "passenger-register" // mobile_no,user_type,fcm_token,first_name,email,password,last_name
        case passengerUserInfoUpdate = "passenger-user-info-update" //name
        case passengerSocialLogin = "passenger-social-login" //user_type,fcm_token,provider,social_uid
        case passengerForgetPassword = "passenger-forget-password" //mobile_no,password
        case passengerUpdatePassword = "passenger-update-password" //old_password,password
        case passengerLogout = "passenger-logout"//
        
        // MARK: - DASHBOARD_ENDPOINT
        case PassengerDashboard = "passenger-dashboard"//
        case saveRating = "passenger-save-rating"//
        case tripHistory = "passenger/trip-history"//
        case passengerStatus = "get-passenger-status"//

        case getNotification = "passenger/get-notifications"//
        case cancelRide = "passenger-cancel-ride"//
        case findDriver = "passenger-find-near-drivers"//
        case createBookingWithAllParam = "passenger-create-booking"//
        case calculateDistanceAndFare = "passenger-calculating-distance-and-fare"//
        case createStrip = "passenger-create-stripe-customer"//
        case getCancelReason = "get-cancel-reason"//

//passenger-create-booking
        ///passenger-calculating-distance-and-fare
        
    }
    
}


