//
//  LoginVM.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class LoginVM: BaseVM {
    
    var number : String = ""
    var code:String = ""
    var actualNumber : String = ""
    
    /*
     if let token = AccessToken.current,
     !token.isExpired {
     // User is logged in, do work such as go to next view controller.
     }
     
     
     loginButton.permissions = ["public_profile", "email"]
     
     let loginButton = FBLoginButton()
     loginButton.center = view.center
     view.addSubview(loginButton)
     */
    
    var isUserAvailable : LoginModel?{
        didSet {
            self.redirectControllerClosure?()
        }
    }
    
    // MARK: - Handling_PhoneAuthetication
    
    
    
    func phoneVerification(){
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(actualNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("verifyNumber",error.localizedDescription)
                    UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: error.localizedDescription)
                    return
                }
                UtilitiesManager.shared.saveOtpVerficationID(id: verificationID ?? "")
                ControllerNavigation.shared.pushVC(of: .enterOTPVC)
            }
    }
    
    
    
    
    // MARK: - API_Handling
    
    func loginAPI(){
        actualNumber = code+number
        guard !number.isEmpty  else{return UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.PHONEFIELD)}
        
        let body = ["mobile_no":actualNumber,"user_type":"1"] as [String:Any]
        NetworkCall(data: body, url: nil, service: APPURL.services.checkPhoneNumber, method: .post).executeQuery(){
            (result: Result<LoginModel,Error>) in
            switch result{
            case .success(let response):
                let isValidUser = response.data.userExist
                UtilitiesManager.shared.saveNumberValidation(isValid: isValidUser)
                let usrDict = ["mobile_no":self.actualNumber]
                UtilitiesManager.shared.saveUserInformation(usr: usrDict)
                self.phoneVerification()
                
            case .failure(let error):
                print("errorzz",error)
            }
        }
        
    }
    
    func socialLoginAPI(email:String,provider:String,socialID:String){
        
        //email,user_type,fcm_token,provider,social_uid
       // actualNumber = code+number
       // guard !number.isEmpty  else{return UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.PHONEFIELD)}
        
        let body = ["email":email,"fcm_token":UtilitiesManager.shared.getFcmToken(),"provider":provider,"social_uid":socialID,"user_type":"1"] as [String:Any]
        NetworkCall(data: body, url: nil, service: APPURL.services.passengerSocialLogin, method: .post).executeQuery(){
            (result: Result<socialDataClass,Error>) in
            switch result{
            case .success(let response):
                print("socialLogin",response.email)
//                let isValidUser = response.data.userExist
//                UtilitiesManager.shared.saveNumberValidation(isValid: isValidUser)
//                let usrDict = ["mobile_no":self.actualNumber]
//                UtilitiesManager.shared.saveUserInformation(usr: usrDict)
//                self.phoneVerification()
                
            case .failure(let error):
                print("errorzz",error)
            }
        }
        
    }
    // MARK: - FACEBOOK_LOGIN

    func fbLogin(vc:UIViewController) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile","email"], from: vc) { result, error in
            if let error = error {
                print("Encountered Erorr: \(error)")
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                print("Logged In")
                Profile.loadCurrentProfile { profile, error in
                    if let firstName = profile?.firstName {
                        print("Hello, \(firstName)")
                        let pro = profile
                        print("profile",profile)
                    }
                }
               // print(Profile.)
            }
        }
    }
    
    // MARK: - GOOGLE_LOGIN

    func gmailLogin(vc:UIViewController){
        
        let signInConfig = GIDConfiguration.init(clientID:Key.Google.clientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: vc) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            //print("user",user.profile?)
        
            /*
             if let profiledata = user.profile {
             let email = profiledata.email
             self.userObj["first_name"] = profiledata.givenName
             self.userObj["last_name"] = profiledata.familyName
             self.userObj["email"] = email
             self.userObj["provider"] = "google"
             self.userObj["mobile_no"] = ""
             var token = ""
             let fcmToken = UtilityManager().getObject(forKey: strToken)
             token = fcmToken
             self.userObj["fcm_token"] = token
             self.userObj["referral_code"] = ""
             self.userObj["type"] = "1"
             self.userObj["countryName"] = UtilityManager().countryName()
             self.userObj["countryCode"] = ""
             self.userObj["device_id"] = ""
             self.userObj["network"] = ""
             self.userObj["version_code"] = Constants.APP_VERSION
             self.userObj["app_version"] = Constants.APP_VERSION
             self.userObj["operating_system"] = Constants.OPERATING_SYSTEM
             /*
              private String countryName;
              private String countryCode;
              private String device_id;
              private String network;
              private String version_code;
              private String app_version;
              private String operating_system;
              */
             self.socialLoginVM.socialLoginApi(dictparam: self.userObj)*/
        }
    }
    
    // MARK: - APPLE_LOGIN

    
    // MARK: - Alert
    
    func errorMsg(str: String) -> Valid {
        return .failure(str)
    }
    // MARK: - Validation
    
    func checkValidation(status:Bool) -> Valid {
        switch status {
        case true:
            return .success
        case false:
            return errorMsg(str:"")
        }
        
    }
    
}
    
  
    



