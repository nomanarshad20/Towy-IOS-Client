//
//  selectLocationVC.swift
//  Towy
//
//  Created by user on 23/08/2022.
//

import UIKit
import GoogleMaps


class selectLocationVC: UIViewController ,GMSMapViewDelegate{

    @IBOutlet weak var MapView: GMSMapView!
    
    var currentLocation = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    private let manager = CLLocationManager()
    var centerMapCoordinate:CLLocationCoordinate2D!
    var marker:GMSMarker!
    
    var selectedLat  = CLLocationDegrees()
    var selectedLong = CLLocationDegrees()
    
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
        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
    }
    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
        if marker == nil {
            marker = GMSMarker()
        }
        marker.position = centerMapCoordinate
        marker.map = self.MapView
    }
}
