//
//  EnterOTPVM.swift
//  Towy
//
//  Created by Usman on 06/07/2022.
//

import Foundation

import Foundation
import UIKit
import FirebaseAuth
class EnterOTPVM: BaseVM {
    
    var number : String = ""
    var timer: Timer?
    var secondsRemaining = 10
    var otpCode : String = ""
    
    var isUserAvailable : LoginModel?{
        didSet {
            self.redirectControllerClosure?()
        }
    }
    
    

    
    // MARK: - COUNTDOWN

    func countdownTimer(lbl:UILabel,btn:UIButton){
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsRemaining > -1 {
                print ("\(self.secondsRemaining) seconds")
//              self.resendCode?.text = self.timeFormatted(self.secondsRemaining)
//                btn.setTitle(, for: .normal)
                 lbl.text = "I haven't received a code(\(self.timeFormatted(self.secondsRemaining)))"
                 btn.isUserInteractionEnabled = false

                self.secondsRemaining -= 1
            } else {
               // btn.setTitle("I haven't received a code", for: .normal)
                lbl.text = "I haven't received a code"
                lbl.textColor = .black

               // btn.tintColor = .black
                btn.isUserInteractionEnabled = true
                self.timerInvalidate()
               // btn.isHidden = false
                //self.timerIsRunnig = false
                //Timer = nil
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func timerInvalidate(){
        self.timer?.invalidate()
        timer = nil
    }
    
    
    
    // MARK: - API_Handling
    
    
    func resendCode(completion:@escaping () -> ()){
        print("numberCode",number)
        SHOW_CUSTOM_LOADER()
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
                HIDE_CUSTOM_LOADER()
                if let error = error {
                    print("verifyNumber",error.localizedDescription)
                    UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: error.localizedDescription)
                    return
                }
                UtilitiesManager.shared.saveOtpVerficationID(id: verificationID ?? "")
                completion()
//                ControllerNavigation.shared.pushVC(of: .enterOTPVC)

            }
    }
    
    func verifyCode(){
        
        SHOW_CUSTOM_LOADER()
        let verificationID = UtilitiesManager.shared.getOtpVerficationID()
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: otpCode)
        
        
        Auth.auth().signIn(with: credential) { authResult, error in
            
            HIDE_CUSTOM_LOADER()
            if let error = error {
              // ...
                print("errorDescription",error.localizedDescription)
                UtilitiesManager().showAlertView(title: Key.APP_NAME, message: error.localizedDescription)
              return
            }
            //print("User is signed in",authResult?.user.phoneNumber)
            
            if UtilitiesManager.shared.isUserExist(){

               // ControllerNavigation.shared.pushVC(of: .welcomeVC)
                self.loginAPI()
            }else{
                ControllerNavigation.shared.pushVC(of: .enterEmailVC)
            }
            // User is signed in
            // ...
        }
//        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//          if let error = error {
//            // ...
//            return
//          }
//          // User is signed in
//          // ...
//        }
    }
//
//    func loginAPI(){
//        let body = ["mobile_no":number,"user_type":"1"] as [String:Any]
//        NetworkCall(data: body, url: nil, service: APPURL.services.checkPhoneNumber, method: .post).executeQuery(){
//            (result: Result<LoginModel,Error>) in
//            switch result{
//            case .success(let response):
////             let vc = EnterOTPVC()
////             vc.isUserExist = true
//            ControllerNavigation.shared.pushVC(of: .enterOTPVC)
//            case .failure(let error):
//                print("errorzz",error)
//            }
//        }
//
//    }
    
    // MARK: - API_Handling
    
    func loginAPI(){
//        actualNumber = code+number
        let usr = UtilitiesManager.shared.getUserInformation()
        let number = usr["mobile_no"]

        guard  let number = number  else{return UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.PHONEFIELD)}
        
        let body = ["mobile_no":number,"user_type":"1","fcm_token":UtilitiesManager.shared.getFcmToken()] as [String:Any]
        NetworkCall(data: body, url: nil, service: APPURL.services.passengerLogin, method: .post).executeQuery(){
            (result: Result<UserLogin,Error>) in
            switch result{
            case .success(let response):
                
                UtilitiesManager.shared.saveLoginUserData(user: response)
                UtilitiesManager.shared.saveUserId(id: response.data.userID)
                UtilitiesManager.shared.saveUserName(name: response.data.firstName)

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.moveToTabbarVC()

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
