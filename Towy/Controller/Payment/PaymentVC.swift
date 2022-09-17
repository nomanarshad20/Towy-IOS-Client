//
//  PaymentVC.swift
//  Towy
//
//  Created by user on 11/08/2022.
//

import UIKit

class PaymentVC: UIViewController {
    
    
    
    @IBOutlet weak var tfName:UITextField!
    @IBOutlet weak var tfCardNumber:UITextField!
    @IBOutlet weak var tfCVC:UITextField!
    @IBOutlet weak var tfMonth:UITextField!
    @IBOutlet weak var tfYear:UITextField!

//    @IBOutlet weak var myCard : MFCardView!
//
    var paymentVm = PaymentVM()
    override func viewDidLoad() {
        super.viewDidLoad()
//        var myCard : MFCardView
//        myCard  = MFCardView(withViewController: self)
        //myCard.delegate = self
//        myCard.autoDismiss = true
//        myCard.toast = true
//        myCard.showCard()
    }
    
    
    @IBAction func btnSubmitAction(_ sender:Any){
        paymentVm.name = self.tfName.text ?? ""
        paymentVm.cvc = self.tfCVC.text ?? ""
        paymentVm.number = self.tfCardNumber.text ?? ""
        paymentVm.month = self.tfMonth.text ?? ""
        paymentVm.year = self.tfYear.text ?? ""

        paymentVm.callStripApi() { data in
            UtilitiesManager.shared.showAlertWithAction(self, message: data.message, title: data.result, buttons: ["OK"]) { index in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
//    func cardTypeDidIdentify(_ cardType: String) {
//        print("")
//    }
//
//    func cardDidClose() {
//        print("")
//        self.navigationController?.popViewController(animated: true)
//    }
    /*
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
    */
//    @IBAction func btnBackAction(){
//        self.navigationController?.popViewController(animated: true)
//    }
    

}


