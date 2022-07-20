//
//  Constans.swift
//  Towy
//
//  Created by Usman on 22/06/2022.
//

import Foundation
import UIKit

//UberMoveText-Bold
//UberMoveText-Medium
//UberMoveText-Regular



//let regularFont = "Roboto-Regular"
//let mediumFont = "Roboto-Medium"
//let boldFont = "Roboto-Bold"


//let regularFont = "Verdana-Italic"
//let mediumFont = "Verdana-Italic"
//let boldFont = "Verdana-Italic"



enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

//ColorConstants.swift

struct AppColor {

    private struct Alphas {
        static let Opaque = CGFloat(1)
        static let SemiOpaque = CGFloat(0.8)
        static let SemiTransparent = CGFloat(0.5)
        static let Transparent = CGFloat(0.3)
    }

    static let appPrimaryColor = UIColor(red: 212/255, green: 213/255, blue: 213/255, alpha: Alphas.Opaque) //UIColor.white.withAlphaComponent(Alphas.SemiOpaque)
    static let appSecondaryColor =  UIColor.blue.withAlphaComponent(Alphas.Opaque)

    struct TextColors {
        static let Error = AppColor.appSecondaryColor
        static let Success = UIColor(red: 0.1303, green: 0.9915, blue: 0.0233, alpha: Alphas.Opaque)
    }

    struct TabBarColors{
        static let Selected = UIColor.white
        static let NotSelected = UIColor.black
    }

    struct OverlayColor {
        static let SemiTransparentBlack = UIColor.black.withAlphaComponent(Alphas.Transparent)
        static let SemiOpaque = UIColor.black.withAlphaComponent(Alphas.SemiOpaque)
        static let demoOverlay = UIColor.black.withAlphaComponent(0.6)
    }
}



 
 //KeyConstants.swift
struct Key {
    
    static let DeviceType = "iOS"
    static let APP_NAME = "TOWY"

//    struct Beacon{
//        static let ONEXUUID = "xxxx-xxxx-xxxx-xxxx"
//    }
//
//    struct UserDefaults {
//        static let k_App_Running_FirstTime = "userRunningAppFirstTime"
//    }
    
    struct Headers {
        static let Authorization = "Authorization"
        static let ContentType = "Content-Type"
    }
    struct Google{
//        static let placesKey = "some key here"//for photos
//        static let serverKey = "some key here"
        static let clientID = "336988954949-6kn7d413lmsu33it24d7bb6h5lqd98hn.apps.googleusercontent.com"
    }
    
    struct ErrorMessage{
        static let INTERNET_ALERT = "Please check your internet connection and try again."
        static let PHONEFIELD = "Phone number field required"
        static let EMAILFIELD = "Email  field required"
        static let FIRSTNAMEFIELD = "First name field required"
        static let LASTNAMEFIELD = "Last name field required"
        static let VALID_EMAIL = "Valid email required"

    }
    
    struct userDefaultKey{
        static let AUTH_VERIFICATION_ID = "authVerificationID"
        static let USER_INFO = "userInformation"
        static let VALID_USER = "isUserValid"
        static let FCM = "fcmToken"
        static let USER_DATA = "userData"
        static let SOCIAL_USER_DATA = "socialUserData"

        static let APPLE_INFORMATION = "apple"

//
    }
    
    struct notificationKey{
        static let DISMISS_CONTROLLER = "dismiss"

    }
    
    
}
 
 


 //FontsConstants.swift
 struct FontNames {

     static let UberMoveTextName = "UberMoveText"
     struct UberMoveText {
        static let regularFont = "UberMoveText-Regular"
        static let mediumFont = "UberMoveText-Medium"
        static let boldFont = "UberMoveText-Bold"
     }
 }
 
 
