//
//  ReasonVC.swift
//  Towy
//
//  Created by Usman on 11/09/2022.
//

import UIKit
import SwiftyJSON
class ReasonVC: UIViewController {

    @IBOutlet weak var tblReasons:UITableView!
    @IBOutlet weak var viewMain:UIView!
    //var dataSource = [Precaution]()
    var reasonVm = ReasonVM()
    var selectedIndex = -1
   // var dataSource : ReasonListModel? = nil
    var dataSource : [Precaution]? = nil

    var booking : BookingInfo? = nil
    var reasonDict :  Precaution? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
 
    

    
    // MARK: - Navigation

  
    
    
    func setUI(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.viewMain.addGestureRecognizer(tap)
        tblReasons.delegate = self
        tblReasons.dataSource = self
        tblReasons.register(UINib.init(nibName: "TextWithCheckboxTableViewCell", bundle: .main), forCellReuseIdentifier: "TextWithCheckboxTableViewCell")
        
        reasonVm.getReasonsData { data in
//            self.dataSource = data
            //            if let data = mainDict?["data"].arrayObject
            let dictionary = try! DictionaryEncoder().encode(data)
            let dict = JSON(dictionary).dictionaryObject
            
            guard let arrObj = dict?["data"] as? [[String:Any]] else{return}
            let dataObj = Precaution.getReasons(data: arrObj)
            self.dataSource = dataObj
//            guard let booking = data["booking"] as? [String:Any] else{
//
//                return
//
//            }

            self.tblReasons.reloadData()
        }

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: false)
    }
    
    @IBAction func btnCancelRideAction(_ sender : Any){
//        self.dismiss(animated: false)
        guard let _ = reasonDict else{return}
        self.reasonVm.bookingId = booking?.id ?? 0
        self.reasonVm.reasonId = reasonDict?.id ?? 0
        self.reasonVm.reason = reasonDict?.text ?? ""
        self.reasonVm.callCancelRideApi {
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name(Key.notificationKey.UPDATE_UI_FOR_CANCEL), object: nil)
            self.dismiss(animated: false)
        }

    }

}

extension ReasonVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextWithCheckboxTableViewCell", for: indexPath) as! TextWithCheckboxTableViewCell
        guard let obj = self.dataSource else {return cell}
        if selectedIndex == indexPath.row{
            cell.imgStatus.image = UIImage.init(named: "check")
        }
        else{
            cell.imgStatus.image = UIImage.init(named: "unCheck")
        }
        cell.setData(data: obj[indexPath.row])
        return cell
        // return cell.setData(data: obj[indexPath.row]) ?? UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let obj = self.dataSource else {return }
        self.reasonDict = obj[indexPath.row]
        self.selectedIndex = indexPath.row
        self.tblReasons.reloadData()
        /*
//        let cel = tableView.cellForRow(at: indexPath) as! TextWithCheckboxTableViewCell
        //SHOW_CUSTOM_LOADER()
        //self.viewTbl.isHidden = true
        guard let obj = self.dataSource else {return }
        self.reasonDict = obj[indexPath.row]
//        cel.data = obj[indexPath.row]
//        _ = cel.changeStatus()
        
        */
        //if let bookinginfo = UtilityManager.manager.getModelFromUserDefalts(key: Constants.CURRENT_RIDE){
//            print("BookingInfo",bookinginfo)
           // let bookingModel = BookingInfo.getRideInfo(dict: bookinginfo)
            //self.stopTimerLocation()
            
//            self.getMessages { b in
//        self.reasonVm.bookingId = booking?.id ?? 0
//        self.reasonVm.reasonId = reasonDict?.id ?? 0
//        self.reasonVm.reason = reasonDict?.reason ?? ""
//        self.reasonVm.callCancelRideApi {
//            self.dismiss(animated: false)
//        }
//            self.cancelBooking(params: ["cancel_reason_id":self.dataSource[indexPath.row].id ?? 0,"booking_id":49,"other_reason":self.dataSource[indexPath.row].text ?? "chal oye","chat_messages": ""])
////            }
            
            
//        }else{
//            print("misssing booking info")
//        }
        
    }
}

