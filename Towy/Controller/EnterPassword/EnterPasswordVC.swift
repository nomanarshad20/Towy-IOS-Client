//
//  EnterPasswordVC.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit

class EnterPasswordVC: UIViewController {
    
    //@IBOutlet weak var btnSignup : UIButton!
    @IBOutlet  var lblTitle : UILabel!
    @IBOutlet  var lblSubtitle : UILabel!
    @IBOutlet  var tfPassword : UITextField!
    @IBOutlet  var btnNext : UIButton!
    @IBOutlet  var btnEye : UIButton!

    
    let passwordVM = EnterPasswordVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //btnSignup.springAnimation()
    }
    
    // MARK: - SETUI
    
    func setUI(){
       // btnSignup.titleLabel?.font = UIFont.myMediumSystemFont(ofSize: 14)
        self.lblTitle.font = UIFont.myMediumSystemFont(ofSize: 25)
        self.lblSubtitle.font = UIFont.myMediumSystemFont(ofSize: 16)
        self.tfPassword.font = UIFont.myMediumSystemFont(ofSize: 18)
        btnNext.titleLabel?.font = UIFont.myBoldSystemFont(ofSize: 14)
        self.tfPassword.delegate = self
        
        var usr = UtilitiesManager.shared.getUserInformation()
        print("usrPPP",usr)

    }
    
    // MARK: - BUTTON ACTION
    
    @IBAction func btnNextAction(_ sender:Any){
        passwordVM.password = self.tfPassword.text!
       // passwordVM.tfPassword = self.tfPassword
        passwordVM.MoveNext()
    }
    @IBAction func btnBackAction(_ sender:Any){
        ControllerNavigation.shared.presentVC(of: .nameConfirmationPopup,.overFullScreen,isAnimate: false)

       // self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnEyeAction(_ sender:Any){
        passwordVM.showHidePassword(btn: self.btnEye, tfpass: tfPassword)
       // ControllerNavigation.shared.pushVC(of: .resetOTPVC)
    }
    
    
}

extension EnterPasswordVC:UITextFieldDelegate{
    
    
    // Use this if you have a UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // make sure the result is under 16 characters
        
        switch textField {
        case tfPassword:
            if updatedText.count > 5{
                self.btnNext.backgroundColor = .black
                self.btnNext.titleLabel?.textColor = .white
                self.btnNext.isUserInteractionEnabled = true
                //self.viewBottomLine.backgroundColor = .green
                //return updatedText.count <= 12
            }else{
                self.btnNext.backgroundColor = AppColor.appPrimaryColor
                self.btnNext.titleLabel?.textColor = .lightGray
                self.btnNext.isUserInteractionEnabled = false

               // self.viewBottomLine.backgroundColor = .red
            }
        
        default:
            print("nothing")
        }
        
        
        return true
    }

    
}
