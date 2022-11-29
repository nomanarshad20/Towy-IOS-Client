//
//  BookingConfirmationVC.swift
//  Towy
//
//  Created by Usman on 12/09/2022.
//

import UIKit

class BookingConfirmationVC: UIViewController {
    
    
    enum BookingFor{
        case services
        case tow
    }
    
    @IBOutlet weak var viewMain:UIView!
    
    var type = BookingFor.tow
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // setUI()
    }
    //    func setUI(){
    //        let nc = NotificationCenter.default
    //        nc.post(name: Notification.Name(Key.notificationKey.DISMISS_CONTROLLER), object: nil)
    //
    //    }
    
    
    
    @IBAction func btnConfirmAction(_ sender:Any){
        
        switch type {
        case .services:
            print("services")
        case .tow:
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name(Key.notificationKey.CALLAPIFORBOOKING), object: nil)

        }
        self.dismiss(animated: false)
    }
    @IBAction func btnCancelAction(_ sender:Any){
        self.dismiss(animated: false)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
