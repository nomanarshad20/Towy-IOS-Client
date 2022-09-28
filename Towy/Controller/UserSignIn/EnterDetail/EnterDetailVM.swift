//
//  EnterDetailVM.swift
//  Towy
//
//  Created by Usman on 14/07/2022.
//

import Foundation

class EnterDetailVM: BaseVM {
    
    var firstName : String = ""
    var lastName:String = ""
//    var actualNumber : String = ""

    
//    var isUserAvailable : LoginModel?{
//        didSet {
//            self.redirectControllerClosure?()
//        }
//    }
    

    

    
    // MARK: - API_Handling
    
    func signUpAPI( completion : @escaping(RegisterUser) -> ()){
        
        
//        actualNumber = code+number
     //  guard !number.isEmpty  else{return UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.PHONEFIELD)}

        //first_name,email,mobile_no,user_type,fcm_token,password,last_name
        
        
        if firstName.isEmpty {
            UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.FIRSTNAMEFIELD)
            return
        }
        if lastName.isEmpty{
            UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: Key.ErrorMessage.LASTNAMEFIELD)

            return
        }
        //guard !firstName.isEmpty && !lastName.isEmpty else{return}
        
        var usr = UtilitiesManager.shared.getUserInformation()
        usr["user_type"] = "1"
        usr["fcm_token"] = UtilitiesManager.shared.getFcmToken()
        usr["first_name"] = firstName
        usr["last_name"] = lastName
        print("body",usr)
        //let body = ["user_type":"1"] as [String:Any]
        NetworkCall(data: usr, url: nil, service: APPURL.services.passengerRegister, method: .post).executeQuery(){
            (result: Result<RegisterUser,Error>)  in
            switch result{
            case .success(let response):
                completion(response)
                //let isValidUser = response.data.email
                
                //ControllerNavigation.shared.pushVC(of: .termConditions)

                
               // UtilitiesManager.shared.saveNumberValidation(isValid: isValidUser)
//                let usrDict = ["number":self.actualNumber]
//                UtilitiesManager.shared.saveUserInformation(usr: usrDict)
//               // self.phoneVerification()
                
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
