//
//  LocationVC.swift
//  Towy
//
//  Created by user on 31/07/2022.
//

import UIKit
import GoogleMaps
import GooglePlaces

class LocationVC: UIViewController,GMSMapViewDelegate{
    
    
//    var resultsViewController: GMSAutocompleteResultsViewController?
//    var searchController: UISearchController?
//    var resultView: UITextView?
//
    @IBOutlet weak var mapView: GMSMapView!

    private let manager = CLLocationManager()
    
//    var currentLat  = CLLocationDegrees()
//    var currentLong = CLLocationDegrees()
//
//    var sourceLat  = CLLocationDegrees()
//    var sourceLong = CLLocationDegrees()
//
//    var destinationLat  = CLLocationDegrees()
//    var destinationLong = CLLocationDegrees()
    
//    var myMapView:GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        self.tabBarController?.tabBar.isHidden = true

//        manager.delegate = self
//        manager.startUpdatingLocation()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // setupMapView()
     //   autocompleteClicked()
    }
    
    func setupMap(){
        // 1
        manager.delegate = self

         // 2
         if CLLocationManager.locationServicesEnabled() {
           // 3
             manager.requestLocation()

           // 4
           mapView.isMyLocationEnabled = true
           mapView.settings.myLocationButton = true
           //mapView.isUserInteractionEnabled  = true
//           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(triggerTouchAction))
             //mapView.addGestureRecognizer(tapGesture)

         } else {
           // 5
             manager.requestWhenInUseAuthorization()
         }
    }
    
    
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSearchAction(_ sender:Any){
        //self.navigationController?.popViewController(animated: true)
        ControllerNavigation.shared.pushVC(of: .searchLocationVC,isAnimate: false)
    }
    /*
    func setupMapView(){
        let camera = GMSCameraPosition.camera(withLatitude: currentLat, longitude: currentLong, zoom: 10.0)
        myMapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        myMapView.settings.myLocationButton = true
        myMapView.settings.setAllGesturesEnabled(false)
        myMapView.isUserInteractionEnabled  = true
        self.view.addSubview(myMapView!)
        addSourceSearchBar()
        addDestinationSearchBar()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        currentLat  = (location?.coordinate.latitude)!
        currentLong = (location?.coordinate.longitude)!
    }
    
    
    
    
    
    
    
    func addSourceSearchBar(){
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        let subView = UIView(frame: CGRect(x: 0, y: 25.0, width: 350.0, height: 45.0))
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.placeholder = "Current location?"
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        searchController?.searchBar.tag = 0
    }
    
    
    func addDestinationSearchBar(){
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        let subView = UIView(frame: CGRect(x: 0, y: 100.0, width: 350.0, height: 45.0))
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.placeholder = "Where to?"
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        searchController?.searchBar.tag = 1
    }
    func autocompleteClicked() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.placeID.rawValue))
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
      }
    */
    }
/*
    extension LocationVC: GMSAutocompleteViewControllerDelegate {
      // Handle the user's selection.
      func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
          
          print()
          
          currentLat  = place.coordinate.latitude
          currentLong = place.coordinate.longitude
          let camera = GMSCameraPosition.camera(withLatitude: currentLat, longitude: currentLong, zoom: 10.0)
          myMapView.animate(to: camera)
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
      }

      func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
      }

      // User canceled the operation.
      func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
      }

      // Turn the network activity indicator on and off again.
      func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      }

      func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
      }

    }
*/
/*
extension LocationVC: GMSAutocompleteResultsViewControllerDelegate {
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didAutocompleteWith place: GMSPlace) {
    searchController?.isActive = false
    currentLat  = place.coordinate.latitude
    currentLong = place.coordinate.longitude
    let camera = GMSCameraPosition.camera(withLatitude: currentLat, longitude: currentLong, zoom: 17.0)
    myMapView.animate(to: camera)
      
    // Do something with the selected place.
    print("Place name: \(place.name)")
    print("Place address: \(place.formattedAddress)")
    print("Place attributions: \(place.attributions)")
  }

  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }
}
*/

// MARK: - CLLocationManagerDelegate

//1
extension LocationVC: CLLocationManagerDelegate {
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
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
  }

  // 6
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }

    // 7
    mapView.camera = GMSCameraPosition(
      target: location.coordinate,
      zoom: 15,
      bearing: 0,
      viewingAngle: 0)
    mapView.delegate = self
  }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
}
