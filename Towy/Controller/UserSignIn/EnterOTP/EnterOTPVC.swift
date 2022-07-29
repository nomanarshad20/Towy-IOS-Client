//
//  EnterOTPVC.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit
import SVPinView

class EnterOTPVC: UIViewController {

    @IBOutlet weak var btnNext : UIButton!
    @IBOutlet  var lblTitle : UILabel!
    @IBOutlet  var lblTimer : UILabel!

    @IBOutlet  var btnTimer : UIButton!
    @IBOutlet  var viewPin : SVPinView!
    let OtpVM = EnterOTPVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        notificationSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // btnNext.springAnimation()
    }
    

    // MARK: - SETUI

    
    func setUI(){
        configurePinView()
        lblTimer.font = UIFont.myMediumSystemFont(ofSize: 14)
        self.lblTitle.font = UIFont.myMediumSystemFont(ofSize: 25)
        self.lblTimer.textColor = .lightGray
        let usr = UtilitiesManager.shared.getUserInformation()
        let number = usr["mobile_no"]
        self.lblTitle.text = "Enter the 6-digit code sent to you at \(number ?? "+92******")"
        print("isUserExist",UtilitiesManager.shared.isUserExist())
        OtpVM.countdownTimer(lbl: lblTimer, btn: self.btnTimer)
    }
    
    // MARK: - Configuration of PinView
    func configurePinView() {
        viewPin.pinLength = 6

        viewPin.secureCharacter = "\u{25CF}"
//        pinView.interSpace = 10
        viewPin.textColor = .black
        viewPin.borderLineColor = .clear
        
        //pinView.borderLineColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        viewPin.activeBorderLineColor = .black
        viewPin.borderLineThickness = 1
        viewPin.shouldSecureText = false
        viewPin.allowsWhitespaces = false
        viewPin.style = .box

        //pinView.style = .underline
        viewPin.activeBorderLineThickness = 3
        viewPin.fieldBackgroundColor = AppColor.appPrimaryColor
        viewPin.activeFieldBackgroundColor = AppColor.appPrimaryColor
        viewPin.fieldCornerRadius = 0
        viewPin.activeFieldCornerRadius = 0
        viewPin.placeholder = ""
        viewPin.becomeFirstResponderAtIndex = 0
        viewPin.shouldDismissKeyboardOnEmptyFirstField = false
        viewPin.keyboardType = .phonePad
//        let font = UIFont(name: "Montserrat-Medium", size: 22)
//        if font != nil {
//            viewPin.font = font!
//        }else{
//            viewPin.font = UIFont.systemFont(ofSize: 22)
//        }
        viewPin.didFinishCallback = { pin in
            print("The entered pin is \(pin)")
            
                self.OtpVM.otpCode = pin
                self.OtpVM.verifyCode()

            
//            ControllerNavigation.shared.pushVC(of: .enterEmailVC)
            
            
//            self.pin = pin
//            let params = [
//                "otp_code": pin,
//                "user_id" : self.userObj["id"] as? String ?? ""
//            ] as [String:Any]
//            self.codeVerifyVM.codeVerifyApi(pin: pin, token: "\(self.userObj["token"] as? String ?? "")", dictparam: params)
        }
        
    }
    // MARK: - NOTIFICATION_OBSERVER
    func notificationSetup(){
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(popControllerObserver), name: Notification.Name(Key.notificationKey.DISMISS_CONTROLLER), object: nil)

    }
    @objc func popControllerObserver(){
        OtpVM.timerInvalidate()
        self.navigationController?.popToSpecificController(ofClass: LoginVC.self, animated: true)
    }
    
    
     // MARK: - BUTTON ACTION


    @IBAction func btnNextAction(_ sender:Any){
        //ControllerNavigation.shared.pushVC(of: .enterEmailVC)
    }
    @IBAction func btnBackAction(_ sender:Any){
        ControllerNavigation.shared.presentVC(of: .nameConfirmationPopup,.overFullScreen,isAnimate: false)
    }
    @IBAction func btnResendAction(_ sender:Any){
        
        ControllerNavigation.shared.presentVC(of: .resendCodePopup,.overFullScreen , isAnimate: false)
        //OtpVM.resendCode(completion: <#() -> ()#>)
        //ControllerNavigation.shared.pushVC(of: .enterEmailVC)
    }


 
 
    
 
 
 
    

}
