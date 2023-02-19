//
//  WalletVC.swift
//  Towy
//
//  Created by user on 13/08/2022.
//

import UIKit

class WalletVC: UIViewController {
    
    @IBOutlet weak var cardNoLbl: UILabel!
    
    @IBOutlet weak var walletBlncLbl: UILabel!
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
            if let walletBlnc = bookingData?.data?.passenger?.wallet_balance {
                self.walletBlncLbl.text =  "USD \(walletBlnc.stringValue) $"
            }
//            if bookingData?.data?.passenger?.card_number?.stringValue == nil {
//            } else {
//            self.cardNoLbl.text = bookingData?.data?.passenger?.card_number?.stringValue
//            }
        }
    }
    
    // MARK: - Navigation
    @IBAction func btnAddPaymentAction(_ sender:Any){
//        ControllerNavigation.shared.pushVC(of: .paymentVC)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        vc.isType = .stripe
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddWalletAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        vc.isType = .wallet
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
