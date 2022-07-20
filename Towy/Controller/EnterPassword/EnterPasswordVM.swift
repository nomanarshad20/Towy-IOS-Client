//
//  EnterPasswordVM.swift
//  Towy
//
//  Created by Usman on 18/07/2022.
//

import Foundation
import UIKit
class EnterPasswordVM: BaseVM {
    
    
    enum state {
        case show
        case hide
        var buttonImage: UIImage {
            switch self {
            case .show:
                return #imageLiteral(resourceName: "eye")
            case .hide:
                return #imageLiteral(resourceName: "eye_close")
            }
        }

    }
    var password : String = ""
    var tfPassword = UITextField()
    var currentState: state = .show
//    var btn = UIButton()
//    private var currentState: state = .hide {
//        didSet {
//            DispatchQueue.main.async {
//                self.btnPlay.setImage(self.currentState.buttonImage[0], for: .normal)
//            }
//        }
//    }
    //var img : UIImageView
//    var actualNumber : String = ""

    
//    var isUserAvailable : LoginModel?{
//        didSet {
//            self.redirectControllerClosure?()
//        }
//    }
    

    

    
    // MARK: - API_Handling
    /*
    func loginAPI(){
        
        
//        actualNumber = code+number
     //  guard !number.isEmpty  else{return UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.PHONEFIELD)}

        //first_name,email,mobile_no,user_type,fcm_token,password,last_name
        
        let body = ["user_type":"1"] as [String:Any]
        NetworkCall(data: body, url: nil, service: APPURL.services.checkPhoneNumber, method: .post).executeQuery(){
            (result: Result<LoginModel,Error>) in
            switch result{
            case .success(let response):
                let isValidUser = response.data.userExist
                UtilitiesManager.shared.saveNumberValidation(isValid: isValidUser)
                let usrDict = ["number":self.actualNumber]
                UtilitiesManager.shared.saveUserInformation(usr: usrDict)
                self.phoneVerification()
                
            case .failure(let error):
                print("errorzz",error)
            }
        }
        
    }
    */
    
    
    func MoveNext(){
      //  guard !email.isEmpty else{UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.EMAILFIELD) ;return}
      //  guard isValidEmail(email) else{UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.VALID_EMAIL) ;return}
        var usr = UtilitiesManager.shared.getUserInformation()
        usr["password"] = password
        
        UtilitiesManager.shared.saveUserInformation(usr: usr)
        //usr.
        
        ControllerNavigation.shared.pushVC(of: .enterDetailVC)

        
    }
    
    // MARK: - SET_BUTTON_IMAGE
    func showHidePassword(btn:UIButton,tfpass:UITextField){
        
        if currentState == .hide{
                btn.setImage(self.currentState.buttonImage, for: .normal)
            print("hide")
            tfpass.isSecureTextEntry = true
            currentState = .show
        }else{
            btn.setImage(self.currentState.buttonImage, for: .normal)
            tfpass.isSecureTextEntry = false
            currentState = .hide
            print("show")
        }
        
    }
    
    
    // MARK: - EMAIL_CHECK

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
