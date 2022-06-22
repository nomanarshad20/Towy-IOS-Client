//
//  ViewController.swift
//  Towy
//
//  Created by Usman on 20/06/2022.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var viewPhone : UIView!
    @IBOutlet weak var viewGmail : UIView!
    @IBOutlet weak var viewFB : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    override func viewWillAppear(_ animated: Bool) {
        startAnimation()
    }
    
    // MARK: - BUTTON ACTION

    @IBAction func btnPhoneAction(_ sender:Any){
        ControllerNavigation.shared.pushVC(of: .enterPhoneVC)
    }
    @IBAction func btnGmailAction(_ sender:Any){
        
    }
    @IBAction func btnFBAction(_ sender:Any){
        
    }
    
    
    func startAnimation(){
        viewPhone.springAnimation()
        viewFB.springAnimation(delay: 0.7)
        viewGmail.springAnimation(delay: 0.9)
    }
    
}

