//
//  SearchLocationVC.swift
//  Towy
//
//  Created by Usman on 02/08/2022.
//

import UIKit
import CoreLocation
import GoogleMaps

class SearchLocationVC: UIViewController ,LocationDelagates{

    @IBOutlet weak var tfPickup:UITextField!
    @IBOutlet weak var tfDestination:UITextField!

    @IBOutlet weak var tbSearch:UITableView!
//    var autocompleteResults :[GApiResponse.Autocomplete] = []
    var autocompleteResults :[GApiResponse.Autocomplete] = []

    var CurrentLat  = CLLocationDegrees()
    var CurrentLong = CLLocationDegrees()
    
    var sourceLocation  = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    
    var currentTFTag = 0
    
    
    
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
        self.tfPickup.delegate      = self
        self.tfDestination.delegate = self
        getAddressFromlatLong(lat: CurrentLat, long: CurrentLong, point: "Source")
        sourceLocation = CLLocationCoordinate2D(latitude: CurrentLat, longitude: CurrentLong)
    }
    func OnUpdate(Lat: CLLocationDegrees, Long: CLLocationDegrees , tag: Int) {
        currentTFTag = tag
        if currentTFTag == 0{
            self.sourceLocation = CLLocationCoordinate2D(latitude: Lat, longitude: Long)

            getAddressFromlatLong(lat: Lat, long: Long, point: "Source")
        }else{
            self.destinationLocation = CLLocationCoordinate2D(latitude: Lat, longitude: Long)
            getAddressFromlatLong(lat: Lat, long: Long, point: "Destination")
        }
    }

    
    // MARK: - Navigation

    @IBAction func btnBack(_ sender:Any){
        self.tfDestination?.resignFirstResponder()
        self.tfPickup?.resignFirstResponder()

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
        
        /*
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
        */
    }
    
    func getAddressFromlatLong(lat: Double, long: Double,point:String) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let geocoder = GMSGeocoder()
        var add = ""
        geocoder.reverseGeocodeCoordinate(coordinate) { [self] (response, error) in
          if let address = response?.firstResult() {
            
            guard let arrAddress = address.lines else {return}
              
            if arrAddress.count > 1 {
                add =  (arrAddress[1])
            }else if arrAddress.count == 1 {
                add =  (arrAddress[0])
                if point == "Source"{
                    self.tfPickup.text = add
//                    self.sourceLocation = coordinate

                }else{
                    self.tfDestination.text = add
//                    self.destinationLocation = coordinate
                }
            }
          }
        }
        
        
      }
}


extension SearchLocationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteResults.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesTBCell", for: indexPath) as! PlacesTBCell
        if indexPath.row == autocompleteResults.count {
            //cell.lblTitle.text = ""
            cell.lblTitle.text = "Set location on map"
        }else {
//            cell.lblTitle.text = autocompleteResults[indexPath.row].title
            cell.lblTitle.text = autocompleteResults[indexPath.row].formattedAddress
            //cell.lblSubTitle.text = autocompleteResults[indexPath.row].title

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        tfLocation?.text = autocompleteResults[indexPath.row].formattedAddress
        //        tfLocation?.resignFirstResponder()
        if indexPath.row == autocompleteResults.count{
            
            let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "selectLocationVC") as! selectLocationVC
            if currentTFTag == 0{
            }else{
                vc.sourceLocation = self.sourceLocation
            }
            vc.currentTFTag = currentTFTag
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            var input = GInput()
            input.keyword = autocompleteResults[indexPath.row].placeId
            GoogleApi.shared.callApi(.placeInformation,input: input) { (response) in
                if let place =  response.data as? GApiResponse.PlaceInfo, response.isValidFor(.placeInformation) {
                    DispatchQueue.main.async {
                        // self.searchTableView.isHidden = true
                        if let lat = place.latitude, let lng = place.longitude{
                            let center  = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                            //                        self.selected_lat = center.latitude
                            //                        self.selected_lang = center.longitude
                            let dataToBeSent = ["lat":center.latitude,"lng":center.longitude] as [String : Any]
                            
                            if self.currentTFTag == 0{
                                self.sourceLocation = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
                                self.getAddressFromlatLong(lat: center.latitude, long: center.longitude, point: "Source")
                            }else{
                                if self.tfPickup.text == ""{
                                    self.destinationLocation = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
                                    self.getAddressFromlatLong(lat: center.latitude, long: center.longitude, point: "Destination")
                                }else{
                                    let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "MainMapVC") as! MainMapVC
                                    vc.destinationLocation = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
                                    vc.sourceLocation = self.sourceLocation
                                    self.tfDestination?.resignFirstResponder()
                                    self.tfPickup?.resignFirstResponder()
//                                    vc.strDestination = self.autocompleteResults[indexPath.row].formattedAddress
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                            
                            
                            
                            
                            
                            // self.delegate?.sendDataToMapVC(myData: dataToBeSent)
                            //self.navigationController?.popViewController(animated: true)
                            
                            //
                            //                        if self.delegate != nil && self.selected_lat != 0.0 && self.selected_lang != 0.0 {
                            //
                            //                            let dataToBeSent = ["lat":self.selected_lat,"lng":self.selected_lang]
                            //                            self.delegate?.sendDataToMapVC(myData: dataToBeSent)
                            //                            self.navigationController?.popViewController(animated: true)
                            //                        }
                            //self.mapView.animate(to: GMSCameraPosition.camera(withLatitude:center.latitude, longitude: center.longitude, zoom: 15.0))
                        }
                        //                    self.searchTableView.reloadData()
                    }
                } else { print(response.error ?? "ERROR") }
            }
            
        }
        
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
        
        currentTFTag = textField.tag
//        if textField.tag == 0{
//            self.tfPickup?.text = textField.text ?? ""
//            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
//        }
//        else{
//            if tfPickup.text == ""{
//                getAddressFromlatLong(lat: CurrentLat, long: CurrentLong, point: "Source")
//                self.sourceLocation = CLLocationCoordinate2D(latitude: CurrentLat, longitude: CurrentLong)
//            }
//            self.tfDestination?.text = textField.text ?? ""
//        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
