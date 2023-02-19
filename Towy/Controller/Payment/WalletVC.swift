//
//  WalletVC.swift
//  Towy
//
//  Created by user on 13/08/2022.
//

import UIKit

class WalletVC: UIViewController {

    @IBOutlet weak var cardNoLbl: UILabel!
    
    var mainMapVm = MainMapVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        mainMapVm.getBookingStatus { bookingData,error  in
            guard error == nil else{return}
            print("card",bookingData?.data?.passenger?.card_number as Any)
            if let card = bookingData?.data?.passenger?.card_number?.stringValue,!card.isEmpty{
                self.cardNoLbl.isHidden = false
                self.cardNoLbl.text = card
            }else{
                self.cardNoLbl.isHidden = true
            }
//            if bookingData?.data?.passenger?.card_number?.stringValue == nil {
//            } else {
//            self.cardNoLbl.text = bookingData?.data?.passenger?.card_number?.stringValue
//            }
        }
    }
    
    // MARK: - Navigation
    @IBAction func btnAddPaymentAction(_ sender:Any){
        ControllerNavigation.shared.pushVC(of: .paymentVC)
    }
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    

}
