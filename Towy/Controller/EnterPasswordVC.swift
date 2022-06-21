//
//  EnterPasswordVC.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit

class EnterPasswordVC: UIViewController {

    @IBOutlet weak var btnSignup : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnSignup.springAnimation()
    }

    
     // MARK: - BUTTON ACTION

   @IBAction func btnSignInAction(_ sender:Any){
       ControllerNavigation.shared.pushVC(of: .enterDetailVC)
   }
   @IBAction func btnBackAction(_ sender:Any){
       self.navigationController?.popViewController(animated: true)
   }


}
