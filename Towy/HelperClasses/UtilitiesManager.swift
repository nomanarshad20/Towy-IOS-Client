//
//  UtilitiesManager.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import Foundation
import UIKit


// MARK: - INTERNET CHECK

func IS_INTERNET_AVAILABLE() -> Bool{
    return AIReachabilityManager.sharedManager.isInternetAvailableForAllNetworks()
}
func SHOW_INTERNET_ALERT(vc:UIViewController){
    UtilitiesManager().showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.INTERNET_ALERT)
}

class UtilitiesManager{
    
    static let shared = UtilitiesManager()
    let defaults = UserDefaults.standard

    func showAlertView(title:String?, message:String)
    {
        let alert = UIAlertController(title:title!, message:message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithAction(_ vc:UIViewController, message:String,title:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for index in 0..<buttons.count    {
            
            alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]), forKey: "attributedTitle")
            
            alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]), forKey: "attributedMessage")
            
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: {
                (alert: UIAlertAction!) in
                if(completion != nil){
                    completion(index)
                }
            })
            
            action.setValue(UIColor.black, forKey: "titleTextColor")
            alertController.addAction(action)
        }
        
        vc.present(alertController, animated: true, completion: nil)
    }
 
    // MARK: - RETRIVE_FROM_USERDEFAULT
    func getOtpVerficationID() -> String
    {
        let result = "\(defaults.value(forKey: Key.userDefaultKey.AUTH_VERIFICATION_ID) ?? "")"
        return result
    }
    
    func getUserInformation() -> [String:Any]{
        
             let dict = defaults.dictionary(forKey: Key.userDefaultKey.USER_INFO)
            print("user data",dict ?? [:])
            return dict ?? [:]
        
    }
    
    func getFcmToken() -> String
    {
        let result = "\(defaults.value(forKey: Key.userDefaultKey.FCM) ?? "")"
        return result
    }
    
    
    func isUserExist() -> Bool{
        let result = defaults.value(forKey: Key.userDefaultKey.VALID_USER) as? Bool
        return result ?? false

    }
    func retriveUserData() -> RegisterUser?{
        do {
            let getData = try defaults.getObject(forKey: Key.userDefaultKey.USER_DATA, castTo: RegisterUser.self)
            return getData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    func retriveSocialUserData() -> SocialUser?{
        do {
            let getData = try defaults.getObject(forKey: Key.userDefaultKey.SOCIAL_USER_DATA, castTo: SocialUser.self)
            return getData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    func retriveUserLoginData() -> UserLogin?{
        do {
            let getData = try defaults.getObject(forKey: Key.userDefaultKey.USER_LOGIN_DATA, castTo: UserLogin.self)
            return getData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    func retriveAppleInformationSession() -> [String:Any]{
        let defaults = UserDefaults.standard
        let dict = defaults.dictionary(forKey: Key.userDefaultKey.APPLE_INFORMATION)
        //let value = NewRideModel
        return dict ?? [:]
    }
    // MARK: - SAVE_IN_USERDEFAULT

    func saveOtpVerficationID(id:String)
    {
        defaults.set(id, forKey: Key.userDefaultKey.AUTH_VERIFICATION_ID)
        
    }
    func saveFCM_Token(token:String)
    {
        defaults.set(token, forKey: Key.userDefaultKey.FCM)
        
    }
    func saveUserInformation(usr:[String:Any])
    {
        //let defaults = UserDefaults.standard
        defaults.set(usr, forKey: Key.userDefaultKey.USER_INFO)
        
    }
    
    
    func saveNumberValidation(isValid:Bool){
        defaults.set(isValid, forKey: Key.userDefaultKey.VALID_USER)

    }
    func saveUserData(user:RegisterUser?){
        do {
            try defaults.setObjects(user, forKey: Key.userDefaultKey.USER_DATA)
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveSocialUserData(user:SocialUser?){
        do {
            try defaults.setObjects(user, forKey: Key.userDefaultKey.SOCIAL_USER_DATA)
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveLoginUserData(user:UserLogin?){
        do {
            try defaults.setObjects(user, forKey: Key.userDefaultKey.USER_LOGIN_DATA)
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveAppleSignInSession(dict:[String:Any])
    {
        let defaults = UserDefaults.standard
        defaults.set(dict, forKey: Key.userDefaultKey.APPLE_INFORMATION)
    }
    
    
    func removeData(){
        saveUserData(user: nil)
        saveLoginUserData(user: nil)
        saveSocialUserData(user: nil)
    }
}

