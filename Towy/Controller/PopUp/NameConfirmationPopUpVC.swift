//
//  NameConfirmationPopUpVC.swift
//  Towy
//
//  Created by Usman on 14/07/2022.
//

import UIKit

class NameConfirmationPopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
    @IBAction func btnYesAction(_ sender:Any){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name(Key.notificationKey.DISMISS_CONTROLLER), object: nil)
        self.dismiss(animated: false)
    }
    @IBAction func btnNoAction(_ sender:Any){
        self.dismiss(animated: false)
    }
}
