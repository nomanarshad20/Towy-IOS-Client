//
//  HomeVC.swift
//  Towy
//
//  Created by user on 26/07/2022.
//

import UIKit
import GoogleMaps
import CoreLocation
import SwiftyJSON


enum requestType : String{
    case service = "service"
    case towing = "tow"
}

class HomeVC: UIViewController , GMSMapViewDelegate , UIGestureRecognizerDelegate{
    // MARK: Outlets
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet var photoSliderView: PhotoSliderView!
    @IBOutlet weak var clcDashBoard:UICollectionView!
    
    @IBOutlet weak var clcDashBoardHeight:NSLayoutConstraint?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var myMapView:GMSMapView!
    var lat  = CLLocationDegrees()
    var long = CLLocationDegrees()
    
    private let manager = CLLocationManager()
    
    let homeVM = HomeVM()
    var objDashboard : DashBoardModel? = nil
    var objBooking : BookingInfo? = nil
    var bookingData: BookingStatusCheckModel? = nil
    var mainMapVm = MainMapVM()

    // MARK: View Methods
    override func viewDidLoad() {
        setupMap()
        registerXib()
        print("AuthHeader",UtilitiesManager.shared.getAuthHeader())
        print("USER_Header",UtilitiesManager.shared.getId())

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        mainMapVm.getBookingStatus { bookingData,error  in
            guard error == nil else{return}

            let dictionary = try! DictionaryEncoder().encode(bookingData)
            let dict = JSON(dictionary).dictionaryObject
            self.bookingData = bookingData
            
            
            guard let data = dict?["data"] as? [String:Any] else{return}
            
            guard let booking = data["booking"] as? [String:Any] else{
                return
            }
        
            
            let b = BookingInfo.getRideInfo(dict: booking)
            self.objBooking = b
//            do{
//            let dict = try JSONDecoder().decode([String: Any].self, from: JSONEncoder().encode(bookingData))
//            }
//            catch{
//
//            }
//            guard error == nil else{return}
//            guard let booking = bookingData?.data.booking else{
//                return
//            }
//
//            guard let bookingDetail = bookingData else{return}
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUI()
    }
    func setUI(){
        homeVM.setDashBoard(photoSliderView: photoSliderView)

    }
    
    func setupMap(){
        // 1
        //manager.delegate = self
        
        // 2
        //if CLLocationManager.locationServicesEnabled() {
            // 3
            //manager.requestLocation()
            
            // 4
//            mapView.isMyLocationEnabled = true
//            mapView.settings.myLocationButton = true
            mapView.delegate = self
            self.mapView.isMyLocationEnabled = false
            mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
            mapView.isUserInteractionEnabled  = true
            setupUserCurrentLocation()

//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(triggerTouchAction))
//            mapView.addGestureRecognizer(tapGesture)
            
//        } else {
//            // 5
//            manager.requestWhenInUseAuthorization()
//        }
    }
//    func loadGoogleMapLayer()
//    {
//
//        let camera = GMSCameraPosition.camera(withLatitude:Constants.DEFAULT_LAT, longitude: Constants.DEFAULT_LONG, zoom: 14.0)
//
//        let screenRect = UIScreen.main.bounds
//        let screenWidth = screenRect.size.width
//        let screenHeight = screenRect.size.height
//        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), camera: camera)
//
//        //        self.lblMarker?.isHidden = true
//        //        self.bearing = "\(camera.bearing)"
//        self.mainMapView.addSubview(mapView)
//        setupUserCurrentLocation()
//
//    }
    
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
    
    
    
    
//    @objc func triggerTouchAction(gestureReconizer: UITapGestureRecognizer) {
//        ControllerNavigation.shared.pushVC(of: .locationVC)
//    }
    func registerXib(){
        self.clcDashBoard.register(UINib(nibName: "NewDashBoardCVCell", bundle: nil), forCellWithReuseIdentifier: "NewDashBoardCVCell")
    }
    
    //DashboardCVCell
    // MARK: - SETUP MAP

    func addDriverMarker(location:CLLocationCoordinate2D,markerImg:String){
        let myMarker = GMSMarker()
        myMarker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        myMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        myMarker.map = self.mapView
        myMarker.icon = UIImage(named: markerImg)
        myMarker.setIconSize(scaledToSize: .init(width: 30, height: 30))
        // print ("Your GMSMarker")
        
    }
    
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return homeVM.setDashBoardData().count
      //  return self.objDashboard?.data.vehicleTypes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewDashBoardCVCell", for: indexPath as IndexPath) as! NewDashBoardCVCell
//        guard let obj = self.objDashboard else{return cell}
//        cell.obj = obj.data.vehicleTypes[indexPath.row]
        cell.lblTitle.text = self.homeVM.setDashBoardData()[indexPath.row].title
        cell.img.image = UIImage(named: self.homeVM.setDashBoardData()[indexPath.row].img)

        //cell.obj = self.dashBoardVM.dashBoard?.data.dashboardContent[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/4 - 8.0
        collectionViewSize.height = collectionViewSize.width
        return collectionViewSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
            
            //guard let _ = self.bookingData?.data?.passenger?.stripe_customer_id
            
            /*
            guard let _ = self.bookingData?.data?.passenger?.stripe_customer_id else {
                UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: "Please add payment method for using tow services")
                return}
            */
            
            //            guard let id = passengerDetail.stripeCustomerID else
            // guard let data = self.objBooking else{return}
            guard let data = self.objBooking else{
                let vc = ControllerNavigation.shared.getVC(of: .searchLocationVC) as! SearchLocationVC
                vc.CurrentLat   = lat
                vc.CurrentLong = long
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
            guard data.request_type == requestType.towing.rawValue else{
                let vc = ControllerNavigation.shared.getVC(of: .searchLocationVC) as! SearchLocationVC
                vc.CurrentLat   = lat
                vc.CurrentLong = long
                self.navigationController?.pushViewController(vc, animated: true)
                return
                
            }
            let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "MainMapVC") as! MainMapVC
            vc.objSocket = data
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        else{
           
            //            let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "SearchLocationForServiceVC") as! SearchLocationForServiceVC
            //            vc.CurrentLat   = lat
            //            vc.CurrentLong = long
            //            self.navigationController?.pushViewController(vc, animated: true)
            guard let data = self.objBooking else{
                let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "SearchLocationForServiceVC") as! SearchLocationForServiceVC
                vc.CurrentLat   = lat
                vc.CurrentLong = long
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
            
            guard data.request_type == requestType.service.rawValue else{
                let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "SearchLocationForServiceVC") as! SearchLocationForServiceVC
                vc.CurrentLat   = lat
                vc.CurrentLong = long
                self.navigationController?.pushViewController(vc, animated: true)
                return
                
            }
            let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "ServicesMapVC") as! ServicesMapVC
            //vc.objBooking = data
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            /*
             let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "ComingSoonVC") as! ComingSoonVC
             self.navigationController?.pushViewController(vc, animated: true)
             */
             
            
        }
        
    }
    
}
//
//extension HomeVC : CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//         print("error:: \(error.localizedDescription)")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            manager.requestLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if locations.first != nil {
//            print("location:: \(locations.first?.coordinate)")
//            print("last:: \(locations.last?.coordinate)")
//
//            lat  = (locations.first?.coordinate.latitude)!
//            long = (locations.first?.coordinate.longitude)!
//
//            setupMapView()
//        }
//
//    }
//
//}

// MARK: - CLLocationManagerDelegate

//1


extension HomeVC: CLLocationManagerDelegate {
  // 2
    /*
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
    */

    
    
  // 6
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        lat = location.coordinate.latitude
        long = location.coordinate.longitude
        // 7
        mapView.camera = GMSCameraPosition(
            target: location.coordinate,
            zoom: 15,
            bearing: 0,
            viewingAngle: 0)
        mapView.delegate = self
//        self.homeVM.fetchDashBoardData { data  in
//            self.objDashboard = data
//            self.clcDashBoard.reloadData()
        self.manager.stopUpdatingLocation()

            self.homeVM.fetchNearestDrivers(location: CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)){ data in
                guard let d = data.data else{return}
                for marker in d{
                    self.addDriverMarker(location: CLLocationCoordinate2D(latitude: marker.latitude ?? 0.0, longitude: marker.longitude ?? 0.0), markerImg: "car_map")
                }
            }
        
        
        
       // }
       
        //self.loadGoogleMapLayer(currentLocation: currentLocation)
        //self.manager.stopUpdatingLocation()
        
    }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
}

// MARK: - GoogleMapsDelegate


extension HomeVC{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("didTapAt")
        guard let data = self.objBooking else{
//             ControllerNavigation.shared.pushVC(of: .locationVC)
            let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
            
//            vc.CurrentLat   = lat
//            vc.CurrentLong = long
            self.navigationController?.pushViewController(vc, animated: true)
             return
        }
        let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "MainMapVC") as! MainMapVC
        vc.objSocket = data
        self.navigationController?.pushViewController(vc, animated: true)


    }
}

