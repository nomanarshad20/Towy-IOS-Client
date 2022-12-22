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
        static let googleApiKey = "AIzaSyBVe-9o7ukhkUBl8hhdNo150Z0eip4EFbw"

    }
    struct Firebase{
        public static var FIREBASE_PUSH_NOTIFICATION_SERVER_KEY = "AAAATnYbYUU:APA91bFPouiB4Wr1NMHrQYuZvUS3RfcAAzGPNWMgrKjfiTEPr1qhjDgGPKDBTbsMGH8TH0zYIoNg_nBIP5QIpwW8UEvqQNx0STgXwXfmnpPA8fUte10MvCtN79q0AcrUHyztP4NBSSUy"
    }
    
    struct ErrorMessage{
        static let INTERNET_ALERT = "Please check your internet connection and try again."
        static let PHONEFIELD = "Phone number field required"
        static let EMAILFIELD = "Email  field required"
        static let FIRSTNAMEFIELD = "First name field required"
        static let LASTNAMEFIELD = "Last name field required"
        static let VALID_EMAIL = "Valid email required"
        static let LOCATION_PERMISSION   = "Please enable Location Services"
        
        
        static let NAMEFIELD = "Name  field required"
        static let CARDNUMBERFIELD = "Card number  field required"
        static let CVCFIELD = "CVC  field required"
        static let MONTHFIELD = "Month  field required"
        static let YEARFIELD = "Year  field required"


    }
    
    struct userDefaultKey{
        static let AUTH_VERIFICATION_ID = "authVerificationID"
        static let USER_INFO = "userInformation"
        static let VALID_USER = "isUserValid"
        static let FCM = "fcmToken"
        static let USER_DATA = "userData"
        static let SOCIAL_USER_DATA = "socialUserData"
        static let USER_LOGIN_DATA = "userLogin"
        static let SERVER_ACCESS_TOKEN = "accessToken"
        static let SAVE_NOTIFICATION = "saveNotificationData"
        static let IS_LOGIN = "isLogin"
        static let SERVER_DRIVER_STATUS = "status"
        static let termsAndConditions = "TermsAndConditions"
        static let SERVER_USER_SID = "id";
        static let SERVER_USER_NAME = "first_name";
        static let USER_TRIP_LOCATION = "tripLocation"
        static let IS_USER_LOGIN = "isLogin"


//SAVE_NOTIFICATION
//
        static let APPLE_INFORMATION = "apple"

//
    }
    
    struct notificationKey{
        static let DISMISS_CONTROLLER = "dismiss"
        static let CALLAPIFORBOOKING = "bookingApiCall"
        static let CALLAPIFORSERVICES = "bookingApiCall"

        static let UPDATE_UI_FOR_CANCEL = "cancelRequest"
        static let APP_BECOME_ACTIVE          = "applicationBecomeActive"
        static let RIDE_CANCEL_BY_DRIVER          = "rideCancel"

//        public enum NotificationType:String{
//            case RIDE_ACCEPT     = "1"
//            case RIDE_REJECT = "0"
//            case NONE = ""
//
//        }
        public enum NotificationStatus:String{
            case RIDE_ACCEPT     = "0"
            case RIDER_REACH = "1"
            case RIDE_START = "2"
            case RIDE_COMPLETE = "3"
            case NONE = ""
        }
        public enum NotificationType:String{
            case RIDE_LOCATION_CHANGED      = "3";
            case NEW_RIDE_REQUEST           = "11"
            case RIDE_CANCELED              = "14";
            case SCHEDULE_RIDE              = "7";
            case LOGOUT_USER                = "8";
            case OFFLINE_PARTNER            = "2";
            case RIDE_CANCEL_ON_RECEIVE     = "15";
            case MESSAGE_RECEIVE            = "20";
            case NONE                       = "0";
            case WARNING                    = "21"
            case BOUNS                      = "22"
            case LOCATION_ERROR_NOTIFICATION = "23"
            
            
        }
        
        public enum NotificationObservers:String{
            
            case RIDE_COMPLETED             = "ride_Completed";
            case DRIVER_RATED_THE_CUSTOMER    = "reting_Completed";
            case RIDE_CANCEL_BY_DRIVER      = "ride_Cancelled";
            case RIDE_CANCEL_BY_USER        = "ride_Cancelled_By_User";
            case RIDE_CANCEL_BY_USER_ON_RECEIVE = "ride_Cancelled_By_User_ON_RECEIVE";
            case RIDE_ACCEPTED              = "ride_Accepted";
            case RIDE_DESTINATION_CHANGED   = "ride_Destination_changed"
            case LUNCH_BY_NOTIFICATION      = "lunchByNotification"
            case APP_BECOME_ACTIVE          = "applicationBecomeActive"
            case APP_ENTER_BACKGROUND       = "applicationEnterBackground"
            case UPDATE_AVAILABLE           = "updateIsAvailable"
            case OFFLINE_USER               = "offlineUser"
            case CHECK_BANNER               = "checkBanner"
            case RESET_BANNER               = "resetBanner"
        }
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
 
 
