//
//  TripDetailVC.swift
//  Towy
//
//  Created by Usman on 08/10/2022.
//

import UIKit
import CoreLocation
import GoogleMaps

class TripDetailsVC: UIViewController {

    
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblSource:UILabel!
    @IBOutlet weak var lblDestination:UILabel!
    @IBOutlet weak var lblTrip:UILabel!

    var obj : PastBooking? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI(){
        guard let obj = self.obj else{return}
        self.lblDate.text = dateToShow(strDate: obj.createdAt ?? "")
        self.lblPrice.text = "PKR \(obj.estimatedFare ?? "00.00")"
        self.lblTrip.text = "Your trip with \(obj.driverFirstName ?? "testDriver")"

        setUIForTowFinder()
    }
    
    func setUIForTowFinder(){
        guard let obj = self.obj else{return}
        let pickUpLat = Double(obj.pickUpLatitude ?? "0.0") ?? 0.0
        let pickUpLong = Double(obj.pickUpLongitude ?? "0.0") ?? 0.0
        let dropOffLat = Double(obj.dropOffLatitude ?? "0.0") ?? 0.0
        let dropOffLong = Double(obj.dropOffLongitude ?? "0.0") ?? 0.0

        let sourceLocation = CLLocationCoordinate2D(latitude: pickUpLat, longitude: pickUpLong)
        let destinationLocation = CLLocationCoordinate2D(latitude: dropOffLat, longitude: dropOffLong)

//        guard let source = self.sourceLocation else{return}
//        guard let destination = self.destinationLocation else{return}

        self.getAddressFromlatLong(lat: sourceLocation.latitude, long: sourceLocation.longitude, lbl: self.lblSource)
        self.getAddressFromlatLong(lat: destinationLocation.latitude, long: destinationLocation.longitude, lbl: self.lblDestination)

    }
    
    
    func dateToShow(strDate:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        //yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, h:mm a"
        
        let date: Date? = dateFormatterGet.date(from: strDate) as Date?
        //        print(dateFormatterPrint.string(from: date! as Date))
        return dateFormatterPrint.string(from: date ?? Date())
    }
    
    func getAddressFromlatLong(lat: Double, long: Double ,lbl:UILabel){
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let geocoder = GMSGeocoder()
        var add = ""
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
          if let address = response?.firstResult() {
            
            guard let arrAddress = address.lines else {return}
            if arrAddress.count > 1 {
                add =  (arrAddress[1])
        
            }else if arrAddress.count == 1 {
                add =  (arrAddress[0])
            }
              lbl.text = add
             // self.currentAddressLbl.text = add
              
          }
        }
        //return add

      }
    // MARK: - Navigation
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnReceiptAction(_ sender:Any){
        let vc = UtilitiesManager.shared.getMainStoryboard().instantiateViewController(withIdentifier: "ReceiptVC") as! ReceiptVC
        guard let obj = self.obj else{return}
        vc.obj = obj
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
