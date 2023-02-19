//
//  URLConstants.swift
//  Towy
//
//  Created by Usman on 05/07/2022.
//

import Foundation
struct APPURL {
    
    /*
     http://52.52.244.89
     http://52.52.244.89:8081
     */
    private struct Domains {
        //Client

        
         static let Dev = "http://52.52.244.89"
         static var socketURL = "http://52.52.244.89:8081"
         
        //Public

//        static let Dev = "http://54.183.143.65"
//        static var socketURL = "http://54.183.143.65:8081"
//
        
        
        /*
         //        static let UAT = "http://test-UAT.com"
         //        static let Local = "192.145.1.1"
         //        static let QA = "testAddress.qa.com"
         */
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
        case tripHistory = "passenger-trip-history"//
        case passengerStatus = "get-passenger-status"//
        
        case getNotification = "passenger/get-notifications"//
        case cancelRide = "passenger-cancel-ride"//
        case findDriver = "passenger-find-near-drivers"//
        case createBookingWithAllParam = "passenger-create-booking"//
        case calculateDistanceAndFare = "passenger-calculating-distance-and-fare"//
        case createStrip = "passenger-create-stripe-customer"//
        case getCancelReason = "get-cancel-reason"//
        case createWallet = "passenger-amount-add-to-wallet"

        
        
        case servicesList = "passenger-service-list"
        case createServiceBooking = "passenger-create-service-booking"
        case sendServiceRideRequest = "send-ride-request-to-driver"

        
        //
        
        
        //passenger-create-booking passenger-create-service-booking
        //passenger-calculating-distance-and-fare
        
    }
    
}


