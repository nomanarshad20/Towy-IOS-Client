//
//  PaymentVC.swift
//  Towy
//
//  Created by user on 11/08/2022.
//

import UIKit
import DropDown
enum Payment {
    case stripe
    case wallet
}
class PaymentVC: UIViewController {
    
    
    
    @IBOutlet weak var tfName:UITextField!
    @IBOutlet weak var tfCardNumber:UITextField!
    @IBOutlet weak var tfCVC:UITextField!
    @IBOutlet weak var tfMonth:UITextField!
    @IBOutlet weak var tfYear:UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var amountView: UIView!
    
    var dropDown = DropDown()
    var arrMonth = [String]()
    var arrYears = [String]()
    var arrOldMonth = [String]()
    var arrDefaultMonth = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var isType: Payment = .stripe
    var datasource = [String]()

//    @IBOutlet weak fileprivate var viewExpiryMonth: LBZSpinner!
//    @IBOutlet weak fileprivate var viewExpiryYear: LBZSpinner!

//    @IBOutlet weak var myCard : MFCardView!
//
    var paymentVm = PaymentVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
//        var myCard : MFCardView
//        myCard  = MFCardView(withViewController: self)
        //myCard.delegate = self
//        myCard.autoDismiss = true
//        myCard.toast = true
//        myCard.showCard()
    }
    
    
    func setUI(){
        
        switch isType {
        case .stripe:
            amountView.isHidden = true
        case .wallet:
            amountView.isHidden = false
        }
        paymentVm.getDateAndMonth(){ month, year in
            self.arrMonth = month
            self.arrYears = year
            self.arrOldMonth = month
            
        }
    }
    
    func setupDropDown(status:Bool = false){
        //var temp = [String]()
        switch status {
        case true:
            dropDown.width = tfYear.frame.width
            dropDown.anchorView = tfYear
            
        case false:
            dropDown.width = tfMonth.frame.width
            dropDown.anchorView = tfMonth
            
        }
        
        /*for i in datasource{
         temp.append(i.first_name ?? "missing name")
         }*/
        dropDown.dataSource = datasource
        //dropDown.dataSource = datasourceYear
        
        dropDown.selectionAction = { [unowned self] (index: Int, type: String) in
            setLable(index: index,status: status)
            if index > 0{
                self.arrMonth = arrDefaultMonth
            }else{
                self.arrMonth = self.arrOldMonth
            }
  
        }
    }
    
    
    func setLable(index:Int,status:Bool = false){
        dropDown.hide()
        switch status {
        case true:
            self.tfYear.text = datasource[index]
        case false:
            self.tfMonth.text = datasource[index]
//            self.monthIndex = index + 1
        }
        
    }
    
    @IBAction func btnSubmitAction(_ sender:Any){
        paymentVm.name = self.tfName.text ?? ""
        paymentVm.cvc = self.tfCVC.text ?? ""
        paymentVm.number = self.tfCardNumber.text ?? ""
        paymentVm.month = self.tfMonth.text ?? ""
        paymentVm.year = self.tfYear.text ?? ""
        paymentVm.amount = self.tfAmount.text ?? "0"
        switch isType {
        case .stripe:
            paymentVm.apiCall() { data in
                UtilitiesManager.shared.showAlertWithAction(self, message: data.message, title: data.result, buttons: ["OK"]) { index in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        
        case .wallet:
            paymentVm.walletApiCall() { data in
                UtilitiesManager.shared.showAlertWithAction(self, message: data.message, title: data.result, buttons: ["OK"]) { index in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    /*
     self.datasource = self.datasourceMonth
     setupDropDown()
     dropDown.show()

     */
    @IBAction func btnMonthAction(_ sender:Any){
        self.datasource = self.arrMonth
        setupDropDown()
        dropDown.show()
    }
    @IBAction func btnYearAction(_ sender:Any){
        self.datasource = self.arrYears
        setupDropDown(status: true)
        dropDown.show()
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


