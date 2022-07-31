//
//  Enums.swift
//  Towy
//
//  Created by Usman on 21/06/2022.
//

import Foundation

import UIKit


// MARK: - For_Controllers

enum SViewController {
    case loginVC
    case enterPhoneVC
    case enterOTPVC
    case enterPasswordVC
    case enterDetailVC
    case resetPasswordVC
    case resetOTPVC
    case enterEmailVC
    case termConditions
    case nameConfirmationPopup
    case welcomeVC
    case resendCodePopup
    case locationVC
    var storyboardName: String {
        switch self {
        case  .loginVC , .enterOTPVC,.enterPhoneVC,.enterDetailVC,.enterPasswordVC,.resetOTPVC,.resetPasswordVC,.enterEmailVC,.termConditions,.nameConfirmationPopup,.welcomeVC,.resendCodePopup,.locationVC:
            return "Main"
        }
    }
    
    var vcIdentifier: String {
        switch self {
        case .loginVC:
            return "LoginVC"
        case .enterPhoneVC:
            return "EnterPhoneNumberVC"
        case .enterOTPVC:
            return "EnterOTPVC"
        case .enterPasswordVC:
            return "EnterPasswordVC"
        case .enterDetailVC:
            return "EnterDetailVC"
        case .resetOTPVC:
            return "ResetOTPVC"
        case .resetPasswordVC:
            return "ResetPasswordVC"
        case .enterEmailVC:
            return "EnterEmailVC"
        case .termConditions:
            return "TermAndCondtionVC"
        case .nameConfirmationPopup:
            return "NameConfirmationPopUpVC"
        case .welcomeVC:
            return "WelcomeVC"
        case .resendCodePopup:
            return "ResendCodePopUpVC"
        case .locationVC:
            return "LocationVC"
            //

        }
    }
}

// MARK: - For_Fonts


enum font{
    case uber
    case robot

}
//font 2
//font 3
//font size
