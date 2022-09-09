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
    @IBOutlet weak var confirmBtnOutlet: UIButton!
    
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
        if currentTFTag == 0{
            confirmBtnOutlet.setTitle("Confirm Pickup", for: .normal)
        }else{
            confirmBtnOutlet.setTitle("Confirm Destination", for: .normal)
        }
    }
 
    func setCurrentLocation(){
        manager.delegate = self
        self.MapView.isMyLocationEnabled = false
       // MapView.settings.allowScrollGesturesDuringRotateOrZoom = false
        MapView.isUserInteractionEnabled  = true
        setupUserCurrentLocation()

         // 2
//         if CLLocationManager.locationServicesEnabled() {
//           // 3
//             manager.requestLocation()
//           // 4
//             MapView.isMyLocationEnabled = true
//             MapView.settings.myLocationButton = true
//         } else {
//           // 5
//             manager.requestWhenInUseAuthorization()
//         }
    }

    
    func setupUserCurrentLocation()
    {
        checkLocationPermission()
        locationManagerInitilize()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
        
        
    }
    
    
    func checkLocationPermission(){
        var status:CLAuthorizationStatus!
        if #available(iOS 14.0, *) {
            status = CLLocationManager().authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            manager.requestAlwaysAuthorization()
            return
            
        case .denied, .restricted:
            
            UtilitiesManager.shared.showAlertWithAction(self, message: Key.ErrorMessage.LOCATION_PERMISSION, title: Key.APP_NAME, buttons: ["Enable","Cancel"]) { index in
                if index == 0{
                    if let BUNDLE_IDENTIFIER = Bundle.main.bundleIdentifier,
                       let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(BUNDLE_IDENTIFIER)") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location permission is granted")
            
        default:
            print("unknow staus")
        }
    }
    
    
    func locationManagerInitilize(){
        if CLLocationManager.locationServicesEnabled(){
            manager.delegate = self
            manager.allowsBackgroundLocationUpdates = false
            manager.showsBackgroundLocationIndicator = true
            manager.requestAlwaysAuthorization()
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            if #available(iOS 14.0, *) {
                manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "Tracking")
            } else {
                // Fallback on earlier versions
            }
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
            let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "MainMapVC") as! MainMapVC
            vc.sourceLocation = sourceLocation
            vc.destinationLocation = destinationLocation
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

/*
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
*/

extension selectLocationVC: CLLocationManagerDelegate {
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
    
//    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
//        if marker == nil {
//            marker = GMSMarker()
//        }
//        marker.position = centerMapCoordinate
//        marker.map = self.MapView
//    }
    
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
