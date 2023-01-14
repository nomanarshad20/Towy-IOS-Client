//
//  UtilitiesManager.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import Foundation
import UIKit
import SDWebImage

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
            
            alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]), forKey: "attributedTitle")
            
            alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]), forKey: "attributedMessage")
            
            
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
 
    
    func setImage(url:String,img:UIImageView){
        let newUrl = APPURL.Domain+"/"+url
        img.sd_setShowActivityIndicatorView(true)
        img.sd_setIndicatorStyle(.gray)
        img.sd_setImage(with: URL(string:newUrl), placeholderImage: UIImage(named: "user"))

    }
    
    func moveBack(_ vc:UIViewController,_ animate:Bool = true){
        if vc.navigationController != nil{
            vc.navigationController?.popViewController(animated: animate)
        }else{
            vc.dismiss(animated: animate, completion: nil)
        }
    }
    // MARK: - GETSTORYBOARD
    func getMapStoryboard() -> UIStoryboard
    {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
        {
            let storyboard = UIStoryboard.init(name: "Maps_iPad", bundle: nil)
            return storyboard
        }
        
        let storyboard = UIStoryboard.init(name: "Maps", bundle: nil)
        return storyboard
    }
    func getMainStoryboard() -> UIStoryboard
    {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
        {
            let storyboard = UIStoryboard.init(name: "Main_iPad", bundle: nil)
            return storyboard
        }
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard
    }
    func getId() -> Int
    {
        let result = UserDefaults.standard.value(forKey: Key.userDefaultKey.SERVER_USER_SID) as? Int
        return result ?? 0
    }
    func getUserName() -> String
    {
        let result = UserDefaults.standard.value(forKey: Key.userDefaultKey.SERVER_USER_NAME) as? String
        return result ?? "iOS_Driver"
    }

    func saveUserId(id:Int){
        defaults.set(id, forKey: Key.userDefaultKey.SERVER_USER_SID)
    }
    func saveUserName(name:String){
        defaults.set(name, forKey: Key.userDefaultKey.SERVER_USER_NAME)
    }
    
    // MARK: - RETRIVE_FROM_USERDEFAULT
    func isTermsAndConditionsPending() -> Bool
       {
           let result = defaults.value(forKey: Key.userDefaultKey.termsAndConditions) as? Bool
           return result ?? false
       }
    
    func getDriverStatus() -> Int
       {
           let result = UserDefaults.standard.value(forKey: Key.userDefaultKey.SERVER_DRIVER_STATUS) as? Int
           return result ?? 0
       }
    func saveDriverStatus(status:Int)
       {
         UserDefaults.standard.setValue(status, forKey: Key.userDefaultKey.SERVER_DRIVER_STATUS)
        UserDefaults.standard.synchronize()
       }
    
    
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
    func getAuthToken() -> String
    {
//        if (UtilitiesManager.shared.retriveSocialUserData() != nil) || (UtilitiesManager.shared.retriveUserLoginData() != nil) || (UtilitiesManager.shared.retriveUserData() != nil) || (UtilitiesManager.shared.retriveAppleLoginData() != nil){
        if (UtilitiesManager.shared.retriveSocialUserData() != nil){
            return UtilitiesManager.shared.retriveSocialUserData()?.data?.access_token?.stringValue ?? ""
        }
        else if (UtilitiesManager.shared.retriveUserLoginData() != nil){
            return UtilitiesManager.shared.retriveUserLoginData()?.data?.access_token?.stringValue ?? ""

        }
        else if (UtilitiesManager.shared.retriveUserData() != nil){
            return UtilitiesManager.shared.retriveUserData()?.data?.access_token?.stringValue ?? ""

        }
        else{
            return ""
        }
//        else{
//            return UtilitiesManager.shared.retriveAppleLoginData()?.data.accessToken ?? ""
//
//        }
            
//        let result = UserDefaults.standard.value(forKey: Key.userDefaultKey.SERVER_ACCESS_TOKEN) as? String
//        return result ?? "0"
    }
    
//    func getAuthToken() -> String
//    {
//            return UtilitiesManager.shared.retriveUserData()?.data.accessToken ?? ""
//
//    }
    func getAuthHeader() -> [String:String]
    {
        let headers = [
            "Authorization": "Bearer \(self.getAuthToken())",
            "Accept": "application/json",
            "Content-Type": "application/json" ]
        return headers
    }
    
    func isUserExist() -> Bool{
        let result = defaults.value(forKey: Key.userDefaultKey.VALID_USER) as? Bool
        return result ?? false

    }
    
    func isLogin() -> Bool{
        let result = defaults.value(forKey: Key.userDefaultKey.IS_USER_LOGIN) as? Bool
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
    func retriveTripLocation() -> UserTripLocationModel?{
        do {
            let getData = try defaults.getObject(forKey: Key.userDefaultKey.USER_TRIP_LOCATION, castTo: UserTripLocationModel.self)
            return getData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    func retriveServiceLocation() -> ServiceLocationModel?{
        do {
            let getData = try defaults.getObject(forKey: Key.userDefaultKey.USER_SERVICE_LOCATION, castTo: ServiceLocationModel.self)
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
    
    func saveTermsAndConditionsState(pending:Bool){
        defaults.set(pending, forKey: Key.userDefaultKey.termsAndConditions)
    }
    
    func saveNumberValidation(isValid:Bool){
        defaults.set(isValid, forKey: Key.userDefaultKey.VALID_USER)

    }
    func saveUserLoginState(isLogin:Bool){
        defaults.set(isLogin, forKey: Key.userDefaultKey.IS_USER_LOGIN)
    }
    func saveUserData(user:RegisterUser?){
        do {
            try defaults.setObjects(user, forKey: Key.userDefaultKey.USER_DATA)
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveUserTripLocation(user:UserTripLocationModel){
        do {
            try defaults.setObjects(user, forKey: Key.userDefaultKey.USER_TRIP_LOCATION)
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveUserServiceLocation(user:ServiceLocationModel){
        do {
            try defaults.setObjects(user, forKey: Key.userDefaultKey.USER_SERVICE_LOCATION)
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
        
        // save data to keyChain
        let data = Data(from: dict)
        let status = saveinKeyChain(key: Key.userDefaultKey.APPLE_INFORMATION, data: data)
        print("status: ", status)
    }
    func saveinKeyChain(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }
    /*
    func saveNotificationSession(userDict:NewRideModel,msg:String)
    {
        let defaults = UserDefaults.standard
        let array = ["booking_id":"\(userDict.booking_id ?? "")","driver_name":"\(userDict.driver_name ?? "")","driver_id":"\(userDict.driver_id ?? "")","driver_long":"\(userDict.driver_long ?? "")","contact_no":"\(userDict.contact_no ?? 0)","vehicle_number":"\(userDict.vehicle_number ?? "")","vehicle_model_year":"\(userDict.vehicle_model_year ?? "")","driver_ratings":"\(userDict.driver_ratings ?? "")","driver_lat":"\(userDict.driver_lat ?? "")","profile_picture":"\(userDict.profile_picture ?? "")","driver_status":"\(userDict.driver_status ?? "")","vehicle_name":"\(userDict.vehicle_name ?? "")","msg":"\(msg)","final_amount":"\(userDict.final_amount ?? "")","final_time":"\(userDict.final_time ?? "")","final_distance":"\(userDict.final_distance ?? "")"]
        defaults.set(array, forKey: Key.userDefaultKey.SAVE_NOTIFICATION)
        print("dicNotification Data save")
        
    }
    */
    func retriveAppleLoginData() -> Data?{
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : Key.userDefaultKey.APPLE_INFORMATION,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }

    func loadAppleLoginDataKeyChain(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    func removeData(){
        saveUserData(user: nil)
        saveLoginUserData(user: nil)
        saveSocialUserData(user: nil)
        saveUserLoginState(isLogin: false)
    }
}

extension Data {
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
