//
//  EnterOTPVC.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit

class EnterOTPVC: UIViewController {

    @IBOutlet weak var btnNext : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnNext.springAnimation()
    }
    


     // MARK: - BUTTON ACTION


    @IBAction func btnNextAction(_ sender:Any){
        ControllerNavigation.shared.pushVC(of: .enterPasswordVC)
    }
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }

    

}
