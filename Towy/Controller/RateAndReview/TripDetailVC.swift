//
//  TripDetailVC.swift
//  Towy
//
//  Created by Usman on 14/09/2022.
//

import UIKit

class TripDetailVC: UIViewController {

    @IBOutlet weak var tblList : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerXib()
    }
    

    
    // MARK: - Navigation
    func registerXib(){
        self.tblList.register(UINib(nibName: "PlacesTBCell", bundle: nil), forCellReuseIdentifier: "PlacesTBCell")

    }

}

extension TripDetailVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripTotalTableViewCell", for: indexPath) as! TripTotalTableViewCell
        //guard let obj = self.objTowList else{return cell}
        //cell.obj = obj.data[indexPath.row]
        //        cell.lblTitle.text = "Lahore"
        //        cell.lblSubTitle.text = autocompleteResults[indexPath.row].formattedAddress
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect")
//        guard let obj = self.objTowList else{return}
//        self.objTow = obj.data[indexPath.row]
//        self.btnConfirm.setTitle("Confirm \(obj.data[indexPath.row].name)", for: .normal)
        
    }
}
