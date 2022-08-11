//
//  PaymentVC.swift
//  Towy
//
//  Created by user on 11/08/2022.
//

import UIKit
import MFCard


class PaymentVC: UIViewController , MFCardDelegate {
    func cardDoneButtonClicked(_ card: Card?, error: String?) {
        print("")
    }
    
    func cardTypeDidIdentify(_ cardType: String) {
        print("")
    }
    
    func cardDidClose() {
        print("")
    }
    
    
    @IBOutlet weak var NumberTF: UITextField!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var ValidityTF: UITextField!
    @IBOutlet weak var cryptoTF: UITextField!
    
    override func viewDidLoad() {
        var myCard : MFCardView
        myCard  = MFCardView(withViewController: self)
        myCard.delegate = self
        myCard.autoDismiss = true
        myCard.toast = true
        myCard.showCard()
    }
}
