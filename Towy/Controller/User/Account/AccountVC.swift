//
//  AccountVC.swift
//  Towy
//
//  Created by user on 26/07/2022.
//

import UIKit

class AccountVC: UIViewController {

    
    
    let accountVM = AccountVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }

    
    
    // MARK: - Navigation

    
    @IBAction func btnHelpAction(_ sender:Any){
        ControllerNavigation.shared.presentVC(of: .helpVC, isAnimate: true)
    }
    
    @IBAction func btnWalletAction(_ sender:Any){
        
    }
    
    @IBAction func btnTripAction(_ sender:Any){
        
    }

    @IBAction func btnProfileAction(_ sender:Any){
        ControllerNavigation.shared.presentVC(of: .editAccountVC, isAnimate: true)

    }
}


extension AccountVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountVM.setTableData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTBCell", for: indexPath) as! AccountTBCell
        cell.obj = accountVM.setTableData()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            UtilitiesManager.shared.removeData()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.moveToHomeVC()

        }
    }
    
}
