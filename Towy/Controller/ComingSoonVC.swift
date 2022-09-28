//
//  ComingSoonVC.swift
//  Towy
//
//  Created by Usman on 20/09/2022.
//

import UIKit

class ComingSoonVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true

    }
    

    
    // MARK: - Navigation

    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }

}
