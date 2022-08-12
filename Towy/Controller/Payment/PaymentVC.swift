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
    }else{
    print(error!)
    }
    }
    
    @IBAction func btnBackAction(){
        self.navigationController?.popViewController(animated: true)
    }
    

}


