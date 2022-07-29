//
//  EditAccountVC.swift
//  Towy
//
//  Created by Usman on 30/07/2022.
//

import UIKit

class EditAccountVC: UIViewController {

    
    @IBOutlet weak var tblAccountSettings : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerXib()
    }
    

    
    func registerXib(){
        //self.tblAccountSettings.register(UINib(nibName: "AccountSettingTBCell", bundle: nil), forCellWithReuseIdentifier: "AccountSettingTBCell")
        self.tblAccountSettings.register(UINib(nibName: "AccountSettingTBCell", bundle: nil), forCellReuseIdentifier: "AccountSettingTBCell")

    }

}

extension EditAccountVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSettingTBCell", for: indexPath) as! AccountSettingTBCell
        return cell
    }
    
    
}
