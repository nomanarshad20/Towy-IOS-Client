//
//  PaymentVC.swift
//  Towy
//
//  Created by user on 11/08/2022.
//

import UIKit
import MFCard

class PaymentVC: UIViewController , MFCardDelegate {
    
    @IBOutlet weak var myCard : MFCardView!
    
    var paymentVm = PaymentVM()
    override func viewDidLoad() {
        super.viewDidLoad()
//        var myCard : MFCardView
//        myCard  = MFCardView(withViewController: self)
        myCard.delegate = self
//        myCard.autoDismiss = true
//        myCard.toast = true
//        myCard.showCard()
    }
    
    
    func cardTypeDidIdentify(_ cardType: String) {
        print("")
    }
    
    func cardDidClose() {
        print("")
        self.navigationController?.popViewController(animated: true)
    }
    
    func cardDoneButtonClicked(_ card: Card?, error: String?) {
    if error == nil{
        print(card?.number)
        print(card?.name)
        print(card?.cvc)
        print(card?.month)
        print(card?.year)
        paymentVm.cvc = card?.cvc ?? ""
        paymentVm.number = card?.number ?? ""
        paymentVm.name = card?.name ?? ""
        paymentVm.month = card?.month?.rawValue ?? ""
        paymentVm.year = card?.year ?? ""
        paymentVm.callStripApi() { data in
            UtilitiesManager.shared.showAlertWithAction(self, message: data.message, title: data.result, buttons: ["OK"]) { index in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }else{
    print(error!)
    }
    }
    
    @IBAction func btnBackAction(){
        self.navigationController?.popViewController(animated: true)
    }
    

}


