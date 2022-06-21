//
//  Enums.swift
//  Towy
//
//  Created by Usman on 21/06/2022.
//

import Foundation

import UIKit

enum SViewController {
    case loginVC
    case enterPhoneVC
    case enterOTPVC
    case enterPasswordVC
    case enterDetailVC
   
    var storyboardName: String {
        switch self {
        case  .loginVC , .enterOTPVC,.enterPhoneVC,.enterDetailVC,.enterPasswordVC:
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
        }
    }
}
