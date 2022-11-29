//
//  ProfileVC.swift
//  Towy
//
//  Created by Usman on 13/11/2022.
//

import UIKit

class ProfileVC: UIViewController {

    
    @IBOutlet weak var tfName:UITextField!
    @IBOutlet weak var tfMobile:UITextField!
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfGender:UITextField!
    @IBOutlet weak var tfDOB:UITextField!

    @IBOutlet weak var imgUser:UIImageView!

    
    let editVM = EditAccountVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        
    }
    

    
    
    
    func setUI(){
        
        let arrObj = editVM.getData()
        guard arrObj.count >= 4 else{return}
        self.tfName.text = arrObj[0].subTitle
        self.tfEmail.text = arrObj[2].subTitle
        self.tfMobile.text = arrObj[3].subTitle

        /*
         let obj_1 = ProfileModel(title: "First name", subTitle: social.data.firstName)
         let obj_2 = ProfileModel(title: "Last name", subTitle: social.data.lastName )
         let obj_3 = ProfileModel(title: "Email", subTitle: social.data.email )
         let obj_4 = ProfileModel(title: "Phone", subTitle: social.data.mobileNo ?? "" )
         */
        
        
    }
    // MARK: - Navigation

    
    @IBAction func btnBackAction(_ sender:Any){
        self.dismiss(animated: false)
    }
    @IBAction func btnUpdateAction(_ sender:Any){
        
    }

}
