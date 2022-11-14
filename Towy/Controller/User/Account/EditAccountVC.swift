//
//  EditAccountVC.swift
//  Towy
//
//  Created by Usman on 30/07/2022.
//

import UIKit

class EditAccountVC: UIViewController {

    
    @IBOutlet weak var tblAccountSettings : UITableView!
    
    let editVM = EditAccountVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true

        registerXib()
    }
    

    
    func registerXib(){
        //self.tblAccountSettings.register(UINib(nibName: "AccountSettingTBCell", bundle: nil), forCellWithReuseIdentifier: "AccountSettingTBCell")
        self.tblAccountSettings.register(UINib(nibName: "AccountSettingTBCell", bundle: nil), forCellReuseIdentifier: "AccountSettingTBCell")

    }
    @IBAction func btnBackAction(_ sender:Any){
        self.dismiss(animated: true)
    }

}

extension EditAccountVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editVM.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSettingTBCell", for: indexPath) as! AccountSettingTBCell
        cell.obj = self.editVM.getData()[indexPath.row]
        return cell
    }
    
    
}
