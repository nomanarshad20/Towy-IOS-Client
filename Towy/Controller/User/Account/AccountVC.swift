//
//  AccountVC.swift
//  Towy
//
//  Created by user on 26/07/2022.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var lblName:UILabel!
    
    let accountVM = AccountVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }

    func setUI(){
        if let social = UtilitiesManager.shared.retriveSocialUserData(){
            self.lblName.text = social.data?.first_name ?? ""
        }
        else if let login = UtilitiesManager.shared.retriveUserLoginData(){
            self.lblName.text = login.data.firstName
        }
        else if let register = UtilitiesManager.shared.retriveUserData(){
            self.lblName.text = register.data.firstName
        }
    }
    
    // MARK: - Navigation

    
    @IBAction func btnHelpAction(_ sender:Any){
        ControllerNavigation.shared.presentVC(of: .helpVC, isAnimate: true)
    }
    
    @IBAction func btnWalletAction(_ sender:Any){
        let vc = UtilitiesManager.shared.getMainStoryboard().instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTripAction(_ sender:Any){
        let vc = UtilitiesManager.shared.getMainStoryboard().instantiateViewController(withIdentifier: "ActivityVC") as! ActivityVC
        vc.isFromTrip = true
        self.navigationController?.pushViewController(vc, animated: true)
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
        if indexPath.row == 1 {
            UtilitiesManager.shared.removeData()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.moveToHomeVC()

        }else{
            let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "MessagesVC") as! MessagesVC
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        
        
    }
    
}
