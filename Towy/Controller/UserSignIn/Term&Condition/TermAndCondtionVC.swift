//
//  TermAndCondtionVC.swift
//  Towy
//
//  Created by Usman on 08/07/2022.
//

import UIKit

class TermAndCondtionVC: UIViewController {
    @IBOutlet  var lblTitle : UILabel!
    @IBOutlet  var lblSubtitle : UILabel!
    @IBOutlet  var lblAccept : UILabel!
    @IBOutlet  var btnNext : UIButton!
    @IBOutlet  var imgCheck : UIImageView!

    var data : RegisterUser? = nil
    
    
    enum state {
        case check
        case uncheck
        var buttonImage: UIImage {
            switch self {
            case .check:
                return #imageLiteral(resourceName: "check")
            case .uncheck:
                return #imageLiteral(resourceName: "unCheck")
            }
        }

    }
    
    private var currentState: state = .uncheck {
        didSet {
            DispatchQueue.main.async {
                self.imgCheck.image = self.currentState.buttonImage
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    

    // MARK: - SETUI
    
    func setUI(){
        btnNext.titleLabel?.font = UIFont.myMediumSystemFont(ofSize: 14)
        self.lblTitle.font = UIFont.myMediumSystemFont(ofSize: 30)
        self.lblSubtitle.font = UIFont.myMediumSystemFont(ofSize: 16)
        self.lblAccept.font = UIFont.myMediumSystemFont(ofSize: 14)

        UtilitiesManager.shared.saveTermsAndConditionsState(pending: true)
        
//        self.tfPassword.font = UIFont.myMediumSystemFont(ofSize: 18)
//        self.tfConfirmPassword.font = UIFont.myMediumSystemFont(ofSize: 18)
    

}
    // MARK: - BUTTON ACTION
    
    @IBAction func btnNextAction(_ sender:Any){
//        passwordVM.password = self.tfPassword.text!
       // passwordVM.tfPassword = self.tfPassword
        //passwordVM.MoveNext()
        //if currentState == .check{
//            ControllerNavigation.shared.pushVC(of: .welcomeVC)
        guard let usr = data else{return}
        UtilitiesManager.shared.saveUserData(user: usr)
        UtilitiesManager.shared.saveUserLoginState(isLogin: true)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.moveToTabbarVC()

        //}
        //ControllerNavigation
    }
    @IBAction func btnBackAction(_ sender:Any){
        ControllerNavigation.shared.presentVC(of: .nameConfirmationPopup,.overFullScreen,isAnimate: false)

       // self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnCheckAction(_ sender:Any){
        
        if currentState == .check{
            currentState = .uncheck

            UtilitiesManager.shared.saveTermsAndConditionsState(pending: true)
            self.btnNext.backgroundColor = AppColor.appPrimaryColor
            self.btnNext.titleLabel?.textColor = .lightGray
            self.btnNext.isUserInteractionEnabled = false

        }
        else{
            currentState = .check
            UtilitiesManager.shared.saveTermsAndConditionsState(pending: false)

            self.btnNext.backgroundColor = .black
            self.btnNext.titleLabel?.textColor = .white
            self.btnNext.isUserInteractionEnabled = true

            
        }
        
//        passwordVM.showHidePassword(btn: self.btnEye, tfpass: tfPassword)
       // ControllerNavigation.shared.pushVC(of: .resetOTPVC)
    }
    
    
    
}
