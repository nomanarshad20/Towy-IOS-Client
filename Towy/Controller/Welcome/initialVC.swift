//
//  initialVC.swift
//  Towy
//
//  Created by Usman on 14/07/2022.
//

import UIKit

class initialVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    @IBAction func btnGetStartedAction(){
        ControllerNavigation.shared.pushVC(of: .loginVC)
    }

}
