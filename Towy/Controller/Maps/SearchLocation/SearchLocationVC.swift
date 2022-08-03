//
//  SearchLocationVC.swift
//  Towy
//
//  Created by Usman on 02/08/2022.
//

import UIKit
//import CoreLocation
//import GoogleMaps

class SearchLocationVC: UIViewController {

    @IBOutlet weak var tfPickup:UITextField!
    @IBOutlet weak var tfDestination:UITextField!

    @IBOutlet weak var tbSearch:UITableView!
    var autocompleteResults :[GApiResponse.Autocomplete] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // Do any additional setup after loading the view.
        setUI()
        registerXib()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tfDestination.becomeFirstResponder()
    }
    
    
    func setUI(){
        self.tabBarController?.tabBar.isHidden = true
        tfPickup.clearButtonMode = .always
        tfPickup.clearButtonMode = .whileEditing
        tfDestination.clearButtonMode = .always
        tfDestination.clearButtonMode = .whileEditing
        self.tfPickup.delegate = self
        self.tfDestination.delegate = self
    }
    

    
    // MARK: - Navigation

    @IBAction func btnBack(_ sender:Any){
        self.navigationController?.popToSpecificController(ofClass: HomeVC.self, animated: true)
    }
    
    
    func registerXib(){
        //self.tblAccountSettings.register(UINib(nibName: "AccountSettingTBCell", bundle: nil), forCellWithReuseIdentifier: "AccountSettingTBCell")
        self.tbSearch.register(UINib(nibName: "PlacesTBCell", bundle: nil), forCellReuseIdentifier: "PlacesTBCell")

    }
    
    
    
    func showResults(string:String){
        var input = GInput()
        input.keyword = string
        GoogleApi.shared.callApi(.autocomplete,input: input) { (response) in
            if response.isValidFor(.autocomplete) {
                DispatchQueue.main.async {
                    //                    self.searchTableView.isHidden = false
                    print("responseSearch",response.data)
                    self.autocompleteResults = response.data as! [GApiResponse.Autocomplete]
                    self.tbSearch.reloadData()
                }
            } else { print(response.error ?? "ERROR") }
        }
    }
}


extension SearchLocationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesTBCell", for: indexPath) as! PlacesTBCell
        cell.lblTitle.text = "Lahore"
        cell.lblSubTitle.text = autocompleteResults[indexPath.row].formattedAddress

        return cell
    }
    
    
    
    
}


// MARK: - UITextFieldDelegates

extension SearchLocationVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
       // hideResults() ; return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! as NSString
        let fullText = text.replacingCharacters(in: range, with: string)
        if fullText.count > 2 {
            showResults(string:fullText)
        }else{
            
            //hideResults()
        }
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.tfPickup?.text = textField.text ?? ""
        self.tfDestination?.text = textField.text ?? ""

        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
