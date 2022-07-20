//
//  ResendCodePopUpVC.swift
//  Towy
//
//  Created by Usman on 14/07/2022.
//

import UIKit

class ResendCodePopUpVC: UIViewController {

    let OtpVM = EnterOTPVM()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation
    @IBAction func btnResendAction(_ sender:Any){
        let usr = UtilitiesManager.shared.getUserInformation()
        let number = usr["mobile_no"]
        OtpVM.number = number as? String ?? ""

        OtpVM.resendCode {
            //let nc = NotificationCenter.default
//            nc.post(name: Notification.Name(Key.notificationKey.DISMISS_CONTROLLER), object: nil)
            self.dismiss(animated: false)
        }
    }
    @IBAction func btnCancelAction(_ sender:Any){
        self.dismiss(animated: false)
    }

}
