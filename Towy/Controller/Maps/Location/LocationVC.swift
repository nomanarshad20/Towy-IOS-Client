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
    @IBOutlet weak var tblTowList:UITableView!

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomViewTowConstraint: NSLayoutConstraint!

    
    var currentLocation = CLLocationCoordinate2D()
    var sourceLocation  = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    
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
    
    /*
    func getRouteSteps(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {

        let session = URLSession.shared

        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(Key.Google.googleApiKey)")!

        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in

            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {

                print("error in JSONSerialization")
                return

            }



            guard let routes = jsonResult["routes"] as? [Any] else {
                return
            }

            guard let route = routes[0] as? [String: Any] else {
                return
            }

            guard let legs = route["legs"] as? [Any] else {
                return
            }

            guard let leg = legs[0] as? [String: Any] else {
                return
            }

            guard let steps = leg["steps"] as? [Any] else {
                return
            }
              for item in steps {

                guard let step = item as? [String: Any] else {
                    return
                }

                guard let polyline = step["polyline"] as? [String: Any] else {
                    return
                }

                guard let polyLineString = polyline["points"] as? String else {
                    return
                }

                //Call this method to draw path on map
                DispatchQueue.main.async {
                    self.drawPath(from: polyLineString)
                }

            }
        })
        task.resume()
    }
    
    */
    //MARK:- Draw Path line
    /*
    func drawPath(from polyStr: String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = .black
        polyline.map = mapView // Google MapView
        let sourceMarker = GMSMarker()
        sourceMarker.position = currentLocation
//        sourceMarker.title = "Delhi"
//        sourceMarker.snippet = "The Capital of INDIA"
        sourceMarker.map = self.mapView
        
        
        // MARK: Marker for destination location
        let destinationMarker = GMSMarker()
        destinationMarker.position = destinationLocation
//        destinationMarker.title = "Gurugram"
//        destinationMarker.snippet = "The hub of industries"
        destinationMarker.map = self.mapView


        let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: currentLocation, coordinate: destinationLocation))
        mapView.moveCamera(cameraUpdate)
//        let camera = GMSCameraPosition(target: currentLocation, zoom: 10)
//        self.mapView.animate(to: camera)
//        mapView.camera = GMSCameraPosition(
//          target: location.coordinate,
//          zoom: 15,
//          bearing: 0,
//          viewingAngle: 0)
        
        let currentZoom = mapView.camera.zoom
        mapView.animate(toZoom: currentZoom - 1.4)
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
//31.497844954125746, 74.26779974759725
    // 7
    mapView.camera = GMSCameraPosition(
      target: location.coordinate,
      zoom: 15,
      bearing: 0,
      viewingAngle: 0)
    mapView.delegate = self
        /*
        self.currentLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
            self.bottomViewTowConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
       self.getRouteSteps(from: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), to: destinationLocation)
        */
  }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
}
extension LocationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TowListTableViewCell", for: indexPath) as! TowListTableViewCell
//        cell.lblTitle.text = "Lahore"
//        cell.lblSubTitle.text = autocompleteResults[indexPath.row].formattedAddress

        return cell
    }
}
