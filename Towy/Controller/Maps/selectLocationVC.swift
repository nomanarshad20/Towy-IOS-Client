//
//  selectLocationVC.swift
//  Towy
//
//  Created by user on 23/08/2022.
//

import UIKit
import GoogleMaps
public protocol LocationDelagates{
    func OnUpdate(Lat: CLLocationDegrees, Long: CLLocationDegrees,tag:Int)
}

class selectLocationVC: UIViewController ,GMSMapViewDelegate{

    @IBOutlet weak var MapView: GMSMapView!
    
    @IBOutlet weak var currentAddressLbl: UILabel!
    
    public var delegate:LocationDelagates!
    var currentLocation = CLLocationCoordinate2D()
    var sourceLocation = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    private let manager = CLLocationManager()
    var centerMapCoordinate:CLLocationCoordinate2D!
    var marker:GMSMarker!
    
    var selectedLat  = CLLocationDegrees()
    var selectedLong = CLLocationDegrees()
    
    var currentTFTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentLocation()
    }
    
    func setCurrentLocation(){
        manager.delegate = self
         // 2
         if CLLocationManager.locationServicesEnabled() {
           // 3
             manager.requestLocation()
           // 4
             MapView.isMyLocationEnabled = true
             MapView.settings.myLocationButton = true
         } else {
           // 5
             manager.requestWhenInUseAuthorization()
         }
    }

    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popToSpecificController(ofClass: HomeVC.self, animated: true)
        
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmBtnAction(_ sender: Any) {
        if currentTFTag == 0{
            delegate.OnUpdate(Lat: selectedLat, Long: selectedLong , tag:currentTFTag)
            self.navigationController?.popViewController(animated: true)
        }else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
            vc.sourceLocation = sourceLocation
            vc.destinationLocation = destinationLocation
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


extension selectLocationVC: CLLocationManagerDelegate {
  // 2
  func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
  ) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    manager.requestLocation()

    //5
    MapView.isMyLocationEnabled = true
    MapView.settings.myLocationButton = true
  }

  // 6
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
//31.497844954125746, 74.26779974759725
    // 7
      MapView.camera = GMSCameraPosition(
      target: location.coordinate,
      zoom: 15,
      bearing: 0,
      viewingAngle: 0)
        MapView.delegate = self
        self.currentLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.sourceLocation = currentLocation
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
  }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
    
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
         selectedLat = mapView.camera.target.latitude
         selectedLong = mapView.camera.target.longitude
        centerMapCoordinate = CLLocationCoordinate2D(latitude: selectedLat, longitude: selectedLong)
        getAddressFromlatLong(lat: selectedLat, long: selectedLong)
        if currentTFTag == 0{
            sourceLocation = centerMapCoordinate
        }else{
            destinationLocation = centerMapCoordinate
        }
 //       self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
    }
    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
        if marker == nil {
            marker = GMSMarker()
        }
        marker.position = centerMapCoordinate
        marker.map = self.MapView
    }
    func getAddressFromlatLong(lat: Double, long: Double) {
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
              self.currentAddressLbl.text = add
          }
        }
      }
}
