//
//  WalletVC.swift
//  Towy
//
//  Created by user on 13/08/2022.
//

import UIKit

class WalletVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
    @IBAction func btnAddPaymentAction(_ sender:Any){
        ControllerNavigation.shared.pushVC(of: .paymentVC)
    }

}
