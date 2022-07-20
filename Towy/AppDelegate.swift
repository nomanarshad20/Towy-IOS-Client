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

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

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
        
        return true
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
