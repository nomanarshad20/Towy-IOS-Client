//
//  AmountToPayVC.swift
//  Towy
//
//  Created by Usman on 17/09/2022.
//

import UIKit

class AmountToPayVC: UIViewController {

    
    @IBOutlet weak var tblList:UITableView!
    @IBOutlet weak var lblTitle:UILabel!

    
    var arrAmount = [[String:String]]()
    var booking : BookingInfo? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableXib()
        guard let obj = self.booking else{return}
        self.lblTitle.text = "\(obj.actual_fare ?? "0.0")  $"
//        let arrAmount = ["Trip fare":"\(obj.actual_fare ?? "0.0")","Waiting time":"0.0","tolls":"0.0","Credit":"0.0","Grand Total":"\(obj.actual_fare ?? "0.0")"]
        
        self.arrAmount.append(["title":"Trip fare","amount":"\(obj.actual_fare ?? "0.0")"])
        self.arrAmount.append(["title":"Waiting time","amount":"0.0"])
        self.arrAmount.append(["title":"tolls","amount":"0.0"])
        self.arrAmount.append(["title":"Credit","amount":"0.0"])
        self.arrAmount.append(["title":"Grand Total","amount":"\(obj.actual_fare ?? "0.0")"])

       // self.arrAmount = arrAmount
        self.tblList.reloadData()

    }
    

    
    // MARK: - Navigation

    func registerTableXib(){
        self.tblList.register(UINib(nibName: "TripTotalTableViewCell", bundle: nil), forCellReuseIdentifier: "TripTotalTableViewCell")
        
    }
    @IBAction func btnNextAction(_ sender:Any){
        let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "RateAndReviewVC") as! RateAndReviewVC
        vc.booking = self.booking
        self.navigationController?.pushViewController(vc, animated: true)

    }

 

}


extension AmountToPayVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAmount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripTotalTableViewCell", for: indexPath) as! TripTotalTableViewCell
        cell.lblAmount.text = "\(self.arrAmount[indexPath.row]["amount"] ?? "")  $"
        cell.lblTitle.text = self.arrAmount[indexPath.row]["title"]

       // cell.lblAmount.text = obj.
//        cell.obj = obj.data[indexPath.row]
        //        cell.lblTitle.text = "Lahore"
        //        cell.lblSubTitle.text = autocompleteResults[indexPath.row].formattedAddress
        
        return cell
    }
    
 
}
