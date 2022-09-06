//
//  MainMapVC.swift
//  Towy
//
//  Created by Usman on 05/09/2022.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MainMapVC: UIViewController,GMSMapViewDelegate {

    @IBOutlet weak var tblTowList:UITableView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomViewTowConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnConfirm:UIButton!

    
    var currentLocation = CLLocationCoordinate2D()
    var sourceLocation  = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    
    private let manager = CLLocationManager()
    var objTowList :TowListModel? = nil
    var objTow :TowDatum? = nil

    var mainMapVm = MainMapVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableXib()
        self.tabBarController?.tabBar.isHidden = true
        mainMapVm.sourceLocation = self.sourceLocation
        mainMapVm.destinationLocation = self.destinationLocation
        mainMapVm.fetchTowList { data in
            self.objTowList = data
            self.tblTowList.reloadData()
            self.setupMap()

        }
        

    }
    
    func registerTableXib(){
        self.tblTowList.register(UINib(nibName: "TowListTableViewCell", bundle: nil), forCellReuseIdentifier: "TowListTableViewCell")

    }
    
   
    
    func setupMap(){
        
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
//        let camera = GMSCameraPosition.camera(withLatitude:self.sourceLocation.latitude, longitude: self.sourceLocation.longitude, zoom: 15.0)
//
//        mapView.camera = camera
        mapView.delegate = self

        /*
        // 1
        manager.delegate = self

         // 2
         if CLLocationManager.locationServicesEnabled() {
           // 3
             manager.requestLocation()

           // 4
           mapView.isMyLocationEnabled = true
           mapView.settings.myLocationButton = true
         } else {
           // 5
             manager.requestWhenInUseAuthorization()
         }
        */
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
            self.bottomViewTowConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
        self.getRouteSteps(from: self.sourceLocation, to: self.destinationLocation)
    }
    
    
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnConfirmAction(_ sender:Any){
        //self.navigationController?.popViewController(animated: true)
       // ControllerNavigation.shared.pushVC(of: .searchLocationVC,isAnimate: false)
    }


    // MARK: - MAPS_SETTING

    
    
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
    
    //MARK:- Draw Path line
    
    func drawPath(from polyStr: String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = .black
        polyline.map = mapView // Google MapView
        
        self.addMarker(location: self.sourceLocation, markerImg: "circle")
        self.addMarker(location: self.destinationLocation, markerImg: "square")
//        let destinationMarker = GMSMarker()
//        destinationMarker.position = self.destinationLocation
//        destinationMarker.map = self.mapView
//        destinationMarker.setIconSize(scaledToSize: .init(width: 25, height: 25))

        //self.addMarker(location: self.destinationLocation, markerImg: "")

        /*
        let sourceMarker = GMSMarker()
        sourceMarker.position = self.sourceLocation
//        sourceMarker.title = "Delhi"
//        sourceMarker.snippet = "The Capital of INDIA"
        sourceMarker.map = self.mapView
        
        
        // MARK: Marker for destination location
        let destinationMarker = GMSMarker()
        
        destinationMarker.position = self.destinationLocation
//        destinationMarker.title = "Gurugram"
//        destinationMarker.snippet = "The hub of industries"
        destinationMarker.map = self.mapView
*/

        let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: sourceLocation, coordinate: destinationLocation))
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
    
    
    
    func addMarker(location:CLLocationCoordinate2D,markerImg:String){
        let myMarker = GMSMarker()
        myMarker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        myMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        myMarker.map = self.mapView
        myMarker.icon = UIImage(named: markerImg)
        myMarker.setIconSize(scaledToSize: .init(width: 30, height: 30))
        // print ("Your GMSMarker")
        
    }
    
    
    
    
    
    // MARK: - BUTTON ACTION
    
    @IBAction func btnConfirmTow(_ sender:Any){
        guard let obj = self.objTow else{return}
        mainMapVm.sendRequestForBooking(obj: obj) { data in
            print("data successfully sent")
        }
    }
}

extension MainMapVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objTowList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TowListTableViewCell", for: indexPath) as! TowListTableViewCell
        guard let obj = self.objTowList else{return cell}
        cell.obj = obj.data[indexPath.row]
        //        cell.lblTitle.text = "Lahore"
        //        cell.lblSubTitle.text = autocompleteResults[indexPath.row].formattedAddress

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect")
        guard let obj = self.objTowList else{return}
        self.objTow = obj.data[indexPath.row]
        self.btnConfirm.setTitle("Confirm \(obj.data[indexPath.row].name)", for: .normal)
        
    }
}



// MARK: - CLLocationManagerDelegate
/*
//1
extension MainMapVC: CLLocationManagerDelegate,GMSMapViewDelegate{
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
        
//        self.currentLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
//            self.bottomViewTowConstraint.constant = 0
//            self.view.layoutIfNeeded()
//        }
//       self.getRouteSteps(from: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), to: destinationLocation)
        
  }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
}
*/
