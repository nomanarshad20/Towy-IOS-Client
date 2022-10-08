//
//  AppDelegate.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import GoogleSignIn
import FirebaseMessaging
import UserNotifications
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    var navigationontroller : UINavigationController?
    var apiKey = "AIzaSyBsdpz4AX5T6uqLxqJXUgEDtoxd0TIiJ2w"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GMSPlacesClient.provideAPIKey(apiKey)
        GMSServices.provideAPIKey(apiKey)
        
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self // add this
        //        // Initialize Facebook SDK
        //              FBSDKCoreKit.ApplicationDelegate.shared.application(
        //                  application,
        //                  didFinishLaunchingWithOptions: launchOptions
        //              )
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        //registerForPushNotifications()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil{
                
            }
            else{
                
            }
        }
        // by DAIR added check to bypass login screen is user already login
        if UtilitiesManager.shared.isTermsAndConditionsPending(){
            moveToTermsVC()
        }
        else if UtilitiesManager.shared.isLogin(){
            
                moveToTabbarVC()
            
        }
        /*
        else if (UtilitiesManager.shared.retriveSocialUserData() != nil) || (UtilitiesManager.shared.retriveUserLoginData() != nil) || (UtilitiesManager.shared.retriveUserData() != nil) //|| (UtilitiesManager.shared.retriveAppleLoginData() != nil)
        {
            //let data = UtilitiesManager.shared.retriveSocialUserData() 
            moveToTabbarVC()
        }
        */
        return true
    }
    func moveToTabbarVC(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        self.navigationontroller = UINavigationController(rootViewController: VC)
        self.navigationontroller?.navigationBar.isHidden = true
        self.window?.rootViewController = self.navigationontroller
        self.window?.makeKeyAndVisible()
    }
    
    
    func moveToHomeVC(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "initialVC") as! initialVC
        self.navigationontroller = UINavigationController(rootViewController: VC)
        self.navigationontroller?.navigationBar.isHidden = true
        self.window?.rootViewController = self.navigationontroller
        self.window?.makeKeyAndVisible()

    }
    func moveToTermsVC(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "TermAndCondtionVC") as! TermAndCondtionVC
        self.navigationontroller = UINavigationController(rootViewController: VC)
        self.navigationontroller?.navigationBar.isHidden = true
        self.window?.rootViewController = self.navigationontroller
        self.window?.makeKeyAndVisible()

    }
    
    func application(
           _ app: UIApplication,
           open url: URL,
           options: [UIApplication.OpenURLOptionsKey : Any] = [:]
       ) -> Bool {
           ApplicationDelegate.shared.application(
               app,
               open: url,
               sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
               annotation: options[UIApplication.OpenURLOptionsKey.annotation]
           )
       }
  /*
    func handleNotification(){
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
            print("Remote FCM registration token: \(token)")
          }
        }
    }
    */
   /*
    func application(
        _ app: UIApplication,
        open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        var handled: Bool
        
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }
        
        // Handle other custom URL types.
        
        // If not handled by this app, return false.
        return false
    }
 */
}



extension AppDelegate:UNUserNotificationCenterDelegate,MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //UtilityManager().saveObject(obj: fcmToken ?? "", forKey: strToken)
        UtilitiesManager.shared.saveFCM_Token(token: fcmToken ?? "")
        print("FCM registration token: \(fcmToken ?? "")")
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        Messaging.messaging().apnsToken = deviceToken
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if UtilitiesManager.shared.isLogin()
        {
            if let _ = userInfo["aps"] as? [String: AnyObject],
               let obj = NotificationModel.getNotificationType(dict: userInfo) {
                showPopup(noti: obj)
                print("notificationDict",obj)
                //                if UtilitiesManager.shared.getDriverStatus() > 0 {
                //                    showPopup(noti: noti)
                //                }
            }
        }
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler:
            @escaping (UIBackgroundFetchResult) -> Void
    ) {

        
        
        
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UIApplication.shared.applicationIconBadgeNumber += 1
        if UtilitiesManager.shared.isLogin(){
            if let _ = userInfo["aps"] as? [String: AnyObject],
               let noti = NotificationModel.getNotificationType(dict: userInfo) {
                showPopup(noti: noti)
                
                //                if UtilitiesManager.shared.getDriverStatus() > 0 {
                //                    showPopup(noti: noti)
                //                }
            }
        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //        center.removeAllPendingNotificationRequests()
        //        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        let userInfo = notification.request.content.userInfo
        let state : UIApplication.State = UIApplication.shared.applicationState
        if (state == .inactive || state == .background) {
            if #available(iOS 14.0, *) {
                completionHandler([.alert,.badge,.banner,.sound,.list])
            } else {
                completionHandler([.alert,.badge,.sound])
            }
        } else {
            if let _ = userInfo["aps"] as? [String: AnyObject],
               let noti = NotificationModel.getNotificationType(dict: userInfo) {
                //if UtilitiesManager.shared.getDriverStatus() > 0 {
                completionHandler([.sound])
                showPopup(noti: noti)
                //}
            }else{
                
            }
        }
    }
    
    /*

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")

    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive")
    }
    */
    /*
     func registerForRemoteNotifications(){
     if #available(iOS 10.0, *) {
     // For iOS 10 display notification (sent via APNS)
     UNUserNotificationCenter.current().delegate = self
     
     let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
     UNUserNotificationCenter.current().requestAuthorization(
     options: authOptions,
     completionHandler: { _, _ in }
     )
     } else {
     let settings: UIUserNotificationSettings =
     UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
     application.registerUserNotificationSettings(settings)
     }
     
     application.registerForRemoteNotifications()
     
     }
     */
    //
    //    func registerForPushNotifications() {
    //      //1
    //      UNUserNotificationCenter.current()
    //        //2
    //        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
    //          //3
    //          print("Permission granted: \(granted)")
    //        }
    //    }
    
}


extension AppDelegate{
    
    func DismissVCOne() {
        self.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    func showPopup(noti:NotificationModel){
        
        switch noti.type {
        case .NEW_RIDE_REQUEST:
            print("NEW_RIDE_REQUEST")
/*
            if UserDefaults.standard.bool(forKey: Constants.IS_HAPTIC_FEEDBACK){
                if #available(iOS 13.0, *) {
                    UtilityManager.manager.addHapticFeedback(.rigid)
                } else {
                    if #available(iOS 13.0, *) {
                        UtilityManager.manager.addHapticFeedback(.soft)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            
            if !Constants.IS_RIDE_POPUP_VISIBLE{
//                navigateToVC(identifier: "NewRideRequestViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
            }else{
//                let params = ["temp_id":noti.newRide?.temp_id ?? "","user_id":UtilityManager.manager.getId(),"driver_action":2,"pre_book":false] as [String : Any]
//                cancelRide(params: params)
            }
            
        case .SCHEDULE_RIDE:
            if UserDefaults.standard.bool(forKey: Constants.IS_HAPTIC_FEEDBACK){
                if #available(iOS 13.0, *) {
//                    UtilityManager.manager.addHapticFeedback(.rigid)
                } else {
                    // Fallback on earlier versions
                }
            }
//            guard let ride = UtilityManager.manager.getModelFromUserDefalts(key: Constants.CURRENT_RIDE)else{return}
//            if UtilityManager.manager.getDriverStatus() == 2 && ride["driver_status"] as? Int ?? 1 >= 2{
//                navigateToVC(identifier: "NewRideRequestViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
            }
        */
        case .RIDE_LOCATION_CHANGED:
        print("RIDE_LOCATION_CHANGED")

//            navigateToVC(identifier: "RideCancelledByUserViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
        case .RIDE_CANCELED:
        print("RIDE_CANCELED")
            NotificationCenter.default.post(name: NSNotification.Name(Key.notificationKey.RIDE_CANCEL_BY_DRIVER), object: noti)

//            navigateToVC(identifier: "RideCancelledByUserViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
        case .LOGOUT_USER:
        print("LOGOUT_USER")

//            navigateToVC(identifier: "RideCancelledByUserViewController", storyBoard: UtilityManager.manager.getMainStoryboard(), noti: noti)
        case .OFFLINE_PARTNER:
        print("OFFLINE_PARTNER")

//            NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.OFFLINE_USER.rawValue), object: noti)
        case .RIDE_CANCEL_ON_RECEIVE:
        print("RIDE_CANCEL_ON_RECEIVE")

//                NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.RIDE_CANCEL_BY_USER_ON_RECEIVE.rawValue), object: noti)
            
        case .MESSAGE_RECEIVE:
        print("MESSAGE_RECEIVE")

//            let rightView = UIImageView.init(image: #imageLiteral(resourceName: "Mask Group 59"))
//            let banner = FloatingNotificationBanner(title: "New Message", subtitle: noti.message?.message,rightView: rightView, style: .success)
//            banner.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
//            banner.clipsToBounds = true
//            banner.autoDismiss = true
//            banner.haptic = .medium
//            banner.dismissOnSwipeUp = true
//            self.addBadge()
//            banner.onTap = {
//                self.moveToChat()
//            }
//            banner.show(queuePosition: .front, bannerPosition: .top, queue: NotificationBannerQueue.default, on: UIApplication.getTopMostViewController())
        case .BOUNS :
        print("BOUNS")

//            let rightView = UIImageView.init(image: #imageLiteral(resourceName: "Mask Group 59"))
//            let banner = FloatingNotificationBanner(title: "Got Bouns", subtitle: noti.message?.message,rightView: rightView, style: .success)
//            banner.backgroundColor = UIColor.systemGreen
//            banner.clipsToBounds = true
//            banner.autoDismiss = true
//            banner.haptic = .medium
//            banner.dismissOnSwipeUp = true
//            banner.onTap = {
//
//            }
//            banner.show(queuePosition: .front, bannerPosition: .top, queue: NotificationBannerQueue.default, on: UIApplication.getTopMostViewController())
        case .WARNING :
        print("WARNING")

//            let rightView = UIImageView.init(image: #imageLiteral(resourceName: "Mask Group 59"))
//            let banner = FloatingNotificationBanner(title: "Warning", subtitle: noti.message?.message,rightView: rightView, style: .success)
//            banner.backgroundColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
//            banner.clipsToBounds = true
//            banner.autoDismiss = true
//            banner.haptic = .medium
//            banner.dismissOnSwipeUp = true
//            banner.onTap = {
//
//            }
//            banner.show(queuePosition: .front, bannerPosition: .top, queue: NotificationBannerQueue.default, on: UIApplication.getTopMostViewController())
        case .LOCATION_ERROR_NOTIFICATION :
        print("LOCATION_ERROR_NOTIFICATION")

//            let rightView = UIImageView.init(image: #imageLiteral(resourceName: "Mask Group 59"))
//            let banner = FloatingNotificationBanner(title: "Location Error", subtitle: noti.message?.message,rightView: rightView, style: .success)
//            banner.backgroundColor = UIColor.systemRed
//            banner.clipsToBounds = true
//            banner.autoDismiss = true
//            banner.haptic = .medium
//            banner.dismissOnSwipeUp = true
//            banner.onTap = {
//
//            }
//            banner.show(queuePosition: .front, bannerPosition: .top, queue: NotificationBannerQueue.default, on: UIApplication.getTopMostViewController())
        default:
            print("")
        }
        
    }
   
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //SocketIOManager.sharedInstance.closeConnection()
        SocketHelper.shared.disconnectSocket()
    }

//    func applicationDidBecomeActive(_ application: UIApplication) {
//       // SocketIOManager.sharedInstance.establishConnection()
//
//    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {

        NotificationCenter.default.post(name: NSNotification.Name(Key.notificationKey.APP_BECOME_ACTIVE), object: nil)
        UIApplication.shared.applicationIconBadgeNumber = 0
        SocketIOManager.sharedInstance.establishConnection()
    }
}
