//
//  ReceiptVC.swift
//  Towy
//
//  Created by Usman on 08/10/2022.
//

import UIKit

class ReceiptVC: UIViewController {

    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblTitle:UILabel!

    var obj : PastBooking? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI(){
        guard let obj = self.obj else{return}
        self.lblDate.text = dateToShow(strDate: obj.created_at?.stringValue ?? "")
        self.lblPrice.text = "PKR \(obj.estimated_fare?.stringValue ?? "00.00")"
        self.lblTitle.text = "Here's Your receipt for your ride with \(obj.driver_first_name?.stringValue ?? "testDriver")"

    }
    
    
    func dateToShow(strDate:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        //yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, h:mm a"
        
        let date: Date? = dateFormatterGet.date(from: strDate) as Date?
        //        print(dateFormatterPrint.string(from: date! as Date))
        return dateFormatterPrint.string(from: date ?? Date())
    }

    
    // MARK: - Navigation
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
   

}
