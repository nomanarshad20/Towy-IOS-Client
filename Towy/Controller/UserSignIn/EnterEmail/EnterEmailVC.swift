//
//  EnterEmailVC.swift
//  Towy
//
//  Created by Usman on 08/07/2022.
//

import UIKit

class EnterEmailVC: UIViewController {
    @IBOutlet  var lblTitle : UILabel!
    @IBOutlet  var tfEmail : UITextField!
    @IBOutlet weak var btnNext : UIButton!

    
    let emailVM = EnterEmailVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    
    /*
     
     */
    func setUI(){
        self.lblTitle.font = UIFont.myMediumSystemFont(ofSize: 25)
        self.tfEmail.font = UIFont.myMediumSystemFont(ofSize: 18)
        btnNext.titleLabel?.font = UIFont.myMediumSystemFont(ofSize: 14)
        self.tfEmail.delegate = self
    }
    
    
    
    
    
     // MARK: - BUTTON ACTION


    @IBAction func btnNextAction(_ sender:Any){
        emailVM.email = self.tfEmail.text!
        emailVM.MoveNext()
    }
    @IBAction func btnBackAction(_ sender:Any){
        ControllerNavigation.shared.presentVC(of: .nameConfirmationPopup,.overFullScreen,isAnimate: false)

        //self.navigationController?.popViewController(animated: true)
    }
}


extension EnterEmailVC:UITextFieldDelegate{
    
    
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
        case tfEmail:
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
