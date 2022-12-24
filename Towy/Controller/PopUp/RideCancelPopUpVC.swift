//
//  RideCancelPopUpVC.swift
//  Towy
//
//  Created by Usman on 24/12/2022.
//

import UIKit

class RideCancelPopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    @IBAction func btnOkAction(_ sender :Any){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.moveToTabbarVC()

    }

}
