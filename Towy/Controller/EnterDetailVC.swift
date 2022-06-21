//
//  EnterDetailVC.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit

class EnterDetailVC: UIViewController {

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
       // ControllerNavigation.shared.moveToEnterPasswordVC(controller: self)
    }
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }

}
