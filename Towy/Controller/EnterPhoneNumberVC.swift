//
//  EnterPhoneNumberVC.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit

class EnterPhoneNumberVC: UIViewController {

    @IBOutlet weak var btnNext : UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnNext.springAnimation()
    }
    

    
    
     // MARK: - BUTTON ACTION

    @IBAction func btnNextAction(_ sender:Any){
        ControllerNavigation.shared.pushVC(of: .enterOTPVC)
    }
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }


}
