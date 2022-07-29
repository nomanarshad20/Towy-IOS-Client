//
//  EnterDetailVC.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit

class EnterDetailVC: UIViewController {
    
    @IBOutlet weak var btnNext : UIButton!
    @IBOutlet  var lblTitle : UILabel!
    @IBOutlet  var lblSubtitle : UILabel!
    
//    @IBOutlet  var tfPassword : UITextField!
//    @IBOutlet  var tfConfirmPassword : UITextField!
//    @IBOutlet  var tfEmail : UITextField!
    @IBOutlet  var tfName : UITextField!
    @IBOutlet  var tfLastName : UITextField!

//    @IBOutlet  var lblTitlePassword : CustomLabel!
//    @IBOutlet  var lblTitleConfirmPassword : CustomLabel!
//    @IBOutlet  var lblTitleEmail : CustomLabel!
//    @IBOutlet  var lblTitleName : CustomLabel!
    
    
    let detailVM = EnterDetailVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //btnNext.springAnimation()
    }
    
    // MARK: - SETUI
    
    func setUI(){
        btnNext.titleLabel?.font = UIFont.myMediumSystemFont(ofSize: 14)
        self.lblTitle.font = UIFont.myMediumSystemFont(ofSize: 25)
        self.lblSubtitle.font = UIFont.myMediumSystemFont(ofSize: 16)
//        self.tfPassword.font = UIFont.myMediumSystemFont(ofSize: 18)
//        self.tfConfirmPassword.font = UIFont.myMediumSystemFont(ofSize: 18)
        self.tfName.font = UIFont.myMediumSystemFont(ofSize: 18)
        self.tfLastName.font = UIFont.myMediumSystemFont(ofSize: 18)
        self.tfName.delegate = self
        self.tfLastName.delegate = self
        var usr = UtilitiesManager.shared.getUserInformation()
        print("usrdetail",usr)

//        self.tfEmail.font = UIFont.myMediumSystemFont(ofSize: 18)
//        self.lblTitlePassword.font = UIFont.myMediumSystemFont(ofSize: 16)
//        self.lblTitleConfirmPassword.font = UIFont.myMediumSystemFont(ofSize: 16)
//        self.lblTitleName.font = UIFont.myMediumSystemFont(ofSize: 16)
//        self.lblTitleEmail.font = UIFont.myMediumSystemFont(ofSize: 16)
    }
    // MARK: - BUTTON ACTION
    @IBAction func btnNextAction(_ sender:Any){
        // ControllerNavigation.shared.moveToEnterPasswordVC(controller: self)
        
        detailVM.firstName = self.tfName.text!
        detailVM.lastName = self.tfLastName.text!
        detailVM.signUpAPI()
       // ControllerNavigation.shared.pushVC(of: .termConditions)

    }
    @IBAction func btnBackAction(_ sender:Any){
        ControllerNavigation.shared.presentVC(of: .nameConfirmationPopup,.overFullScreen,isAnimate: false)

        //self.navigationController?.popViewController(animated: true)
    }
    
}

extension EnterDetailVC:UITextFieldDelegate{
    
    
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
        case tfName:
            if updatedText.count > 0{
                self.btnNext.backgroundColor = .black
                self.btnNext.titleLabel?.textColor = .white
                self.btnNext.isUserInteractionEnabled = true
                //self.viewBottomLine.backgroundColor = .green
                //return updatedText.count <= 12
            }else{
                self.btnNext.backgroundColor = .lightGray
                self.btnNext.titleLabel?.textColor = .black
                self.btnNext.isUserInteractionEnabled = false

               // self.viewBottomLine.backgroundColor = .red
            }
        case tfLastName:
            if updatedText.count > 0{
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
