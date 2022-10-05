//
//  ActivityVC.swift
//  Towy
//
//  Created by Usman on 27/09/2022.
//

import UIKit

class ActivityVC: UIViewController {

    @IBOutlet weak var tblList : UITableView!
    
    var activityVm = ActivityVM()
    var objTripHistory : TripHistoryModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableXib()
    }
    override func viewDidAppear(_ animated: Bool) {
        callApi()
    }

    
    // MARK: - Navigation
    func registerTableXib(){
        self.tblList.register(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityTableViewCell")
        
    }
    func callApi(){
        activityVm.getTripHistory { data, error in
            guard error == nil else{return}
            self.objTripHistory = data
            if var d = self.objTripHistory?.data.pastBooking{
                d.reverse()
                self.objTripHistory?.data.pastBooking = d
            }
            self.tblList.reloadData()
        }
    }
   

}

extension ActivityVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objTripHistory?.data.pastBooking.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell", for: indexPath) as! ActivityTableViewCell
        guard let obj = self.objTripHistory?.data.pastBooking else{return cell}
        cell.setData(obj: obj[indexPath.row])
        
//        guard let obj = self.objTowList else{return cell}
//        cell.obj = obj.data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect")
//        guard let obj = self.objTowList else{return}
//        self.objTow = obj.data[indexPath.row]
//        self.btnConfirm.setTitle("Confirm \(obj.data[indexPath.row].name)", for: .normal)
        
    }
}
