//
//  ViewController.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit
import AuthenticationServices
import CountryPickerView
//import Firebase
//import Alamofire

class LoginVC: UIViewController{
   
    
    
    @IBOutlet  var setLabelFonts : [UILabel]!
    @IBOutlet weak  var btnNext : UIButton!
    @IBOutlet weak var countryPickerView: CountryPickerView!
    @IBOutlet  var lblCountryCode : CustomLabel!
    @IBOutlet  var tfNumber : UITextField!
    
    let loginVM = LoginVM()

    let appDelegateObj = AppDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
    // MARK: - SETUI
    
    
    func setUI(){
        for i in 0..<setLabelFonts.count{
            switch i{
            case 0:
                setLabelFonts[i].font = UIFont.mySystemFont(ofSize: 22)
            case 1:
                setLabelFonts[i].font = UIFont.mySystemFont(ofSize: 15)
                
            default:
                setLabelFonts[i].font = UIFont.myMediumSystemFont(ofSize: 16)
            }
        }
        self.tfNumber.font = UIFont.myMediumSystemFont(ofSize: 18)
        self.btnNext.titleLabel?.font = UIFont.myBoldSystemFont(ofSize: 16)
        //self.btnNext.fon
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.showCountryCodeInView = false
        countryPickerView.showPhoneCodeInView = false
        self.lblCountryCode.text = countryPickerView.selectedCountry.phoneCode
        
    }
    
    


    
    // MARK: - BUTTON ACTION
    
    @IBAction func btnNextAction(_ sender:Any){
        loginVM.number = self.tfNumber.text!
        loginVM.code = self.lblCountryCode.text!
       // ControllerNavigation.shared.pushVC(of: .enterOTPVC)
        loginVM.loginAPI()
    }
    @IBAction func btnGmailAction(_ sender:Any){
        loginVM.gmailLogin(vc: self)
    }
    @IBAction func btnFBAction(_ sender:Any){
        loginVM.fbLogin(vc: self)
    }
    @IBAction func btnAppleAction(_ sender:Any){
       // loginVM.appleLogin(vc: self)
        if #available(iOS 13.0, *) {
            handleAppleIdRequest()
        } else {
            // Fallback on earlier versions
        }
    }
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
}



@available(iOS 13.0, *)
extension LoginVC:ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let apple = appleIDCredential
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
//            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
            
            var userObj = [String:Any]()

            let email = "\(appleIDCredential.email ?? "N/A")"
            let lastName = "\(appleIDCredential.fullName?.familyName ?? "N/A")"
            let firstName = "\(appleIDCredential.fullName?.givenName ?? "N/A")"
            let id = "\(appleIDCredential.user)"
            if let identityTokenData = appleIDCredential.identityToken,
               let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                print("Identity Token \(identityTokenString)")
                
                if email != "N/A"{
                    userObj["firstName"] = firstName
                    userObj["lastName"] = lastName
                    userObj["email"] = email
                    userObj["tokem"] = identityTokenString
                    userObj["id"] = id

                    UtilitiesManager.shared.saveAppleSignInSession(dict: userObj)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.moveToTabbarVC()

                }
            }


        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}
extension LoginVC:CountryPickerViewDelegate, CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        print("country",country.phoneCode)
        self.lblCountryCode.text = country.phoneCode

    }
    
    
}

