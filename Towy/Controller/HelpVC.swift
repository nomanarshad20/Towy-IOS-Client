//
//  HelpVC.swift
//  Towy
//
//  Created by Usman on 30/07/2022.
//

import UIKit

class HelpVC: UIViewController {

    @IBOutlet weak var tblHelp : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerXib()
    }
    
    
    func registerXib(){
        //self.tblAccountSettings.register(UINib(nibName: "AccountSettingTBCell", bundle: nil), forCellWithReuseIdentifier: "AccountSettingTBCell")
        self.tblHelp.register(UINib(nibName: "HelpTBCell", bundle: nil), forCellReuseIdentifier: "HelpTBCell")

    }


}
extension HelpVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTBCell", for: indexPath) as! HelpTBCell
        return cell
    }
    
    
}
