//
//  ServicesMapVC.swift
//  Towy
//
//  Created by Usman on 14/11/2022.
//

import UIKit

import GoogleMaps
import GooglePlaces
import SocketIO
import SwiftyJSON
import Alamofire
import CoreLocation
import FirebaseDatabase

class ServicesMapVC: UIViewController,GMSMapViewDelegate {
    
    
    enum ServicesType{
        case selectService
        case selectDriver
        case detail
        //        case waitingDriver
        //        case Accept
    }
    
    enum rideStatus{
        case findingTow
        case requestAccept
        case requestReject
        case reach
        case start
        case end
        case notFound
        case rideRejectDuringRide
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var bottomViewTowConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewServiceList: UIView!
    @IBOutlet weak var viewDriverList: UIView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var viewWaiting: UIView!
    @IBOutlet weak var viewDriver: UIView!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewReason: UIView!

    
    
    @IBOutlet weak var tblServicesList:UITableView!
    @IBOutlet weak var tblDriverList:UITableView!
    @IBOutlet weak var tblReasons:UITableView!
    @IBOutlet weak var clcTags : UICollectionView!

    //    @IBOutlet weak var tblDetailList:UITableView!
    
    
    @IBOutlet weak var lblService : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblSourceLocation : UILabel!
    
    
    @IBOutlet weak var imgDriver:UIImageView!
    @IBOutlet weak var lblDriverName:UILabel!
    @IBOutlet weak var lblDriverRideStatus:UILabel!
    @IBOutlet weak var lblDriverTowType:UILabel!
    
    
    @IBOutlet weak var btnBack:UIButton!
    @IBOutlet weak var btnCancelReason:UIButton!
    @IBOutlet weak var driverRating: UIButton!
    @IBOutlet weak var btnCancelServices: UIButton!

    
    
    var sourceLocation  : CLLocationCoordinate2D? = nil
    private let manager = CLLocationManager()
    var servicesVM = ServicesMapVM()
    var mainMapVm = MainMapVM()
    var reasonVm = ReasonVM()
    
    var serviceStatus = ServicesType.selectService
    
    
    var serviceList :ServicesListModel? = nil
    var objServiceBooking :ServicesBookingModel? = nil
    var bookingStatus : BookingStatusCheckModel? = nil
    
    var arrSelectedSerivces = [Services]()
    var arrSerivces = [Services]()
    
    var selectedDriver : DriverList? = nil
    
    var PickupArea = "USA"
    
    
    var isConnectedToSocket = false
    
    let socket = SocketIOManager.sharedInstance.socket
    
    var objBooking:BookingInfo? = nil
    
    
    var timerForRideRequest:Timer!
    var carMarker = GMSMarker()
    
    var driverStatus = 0
    var drawLineStatus = 0
    
    var driverLocation = CLLocationCoordinate2D()
    var bearing = 90.0
    
    
    var reasonDict :  Precaution? = nil
    var dataSource : [Precaution]? = nil
    var selectedIndex = -1

    // MARK: - VIEWCONTROLLER_LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        registerTableXib()
        setupMap()
//        getService{}

        if let source = self.sourceLocation{
            self.PickupArea = servicesVM.getPickAddress(userLocation: CLLocation(latitude: source.latitude, longitude: source.longitude))
            let obj = ServiceLocationModel(sourceLat: source.latitude, sourceLng: source.longitude)
            UtilitiesManager.shared.saveUserServiceLocation(user: obj)
            //self.setUIForTowFinder()
            self.getAddressFromlatLong(lat: source.latitude, long: source.longitude, lbl: self.lblSourceLocation)
            
        }
        
        //        let obj = UserTripLocationModel(sourceLat: source.latitude, sourceLng: source.longitude, destinationLat: destination.latitude, destinationLng: destination.longitude)
        //        UtilitiesManager.shared.saveUserTripLocation(user: obj)
        addSocketListerForRide()
        addSocketListnerRideAcceptReject()
        
        reasonVm.getReasonsData { data in
            let dictionary = try! DictionaryEncoder().encode(data)
            let dict = JSON(dictionary).dictionaryObject
            
            guard let arrObj = dict?["data"] as? [[String:Any]] else{return}
            let dataObj = Precaution.getReasons(data: arrObj)
            self.dataSource = dataObj
            self.tblReasons.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notificationSetup()
        
        mainMapVm.getBookingStatus { bookingData,error  in
            guard error == nil else{return}
            self.bookingStatus = bookingData
            let dictionary = try! DictionaryEncoder().encode(bookingData)
            let dict = JSON(dictionary).dictionaryObject
            print("jsonData",dict)
            guard let data = dict?["data"] as? [String:Any] else{return}
            
            guard let booking = data["booking"] as? [String:Any] else{
                print("bookingMilinhi osy")
                self.checkRideStatus(status: .notFound)
                return
            }
            let b = BookingInfo.getRideInfo(dict: booking)
            self.objBooking = b
            guard self.objBooking != nil else{
                print("notFoundWalaKam")
                self.checkRideStatus(status: .notFound)
                return
            }
            self.checkDriverStatus(driverStatus: self.objBooking?.driver_status ?? 4)
            delay(seconds: 2) {
                self.getDriverLastLocation()
            }
            self.driverStatus =  self.objBooking?.driver_status ?? 4
            self.setUI()
            
        }
        
        /*
         mainMapVm.getBookingStatus { bookingData,error  in
         guard error == nil else{return}
         // self.bookingStatus = bookingData
         let dictionary = try! DictionaryEncoder().encode(bookingData)
         let dict = JSON(dictionary).dictionaryObject
         print("jsonData",dict)
         guard let data = dict?["data"] as? [String:Any] else{return}
         
         guard let booking = data["booking"] as? [String:Any] else{
         print("bookingMilinhi osy")
         // self.checkRideStatus(status: .notFound)
         return
         }
         
         let b = BookingInfo.getRideInfo(dict: booking)
         self.objBooking = b
         /*
          guard self.objSocket != nil else{
          print("notFoundWalaKam")
          self.checkRideStatus(status: .notFound)
          return
          }
          self.checkDriverStatus(driverStatus: self.objSocket?.driver_status ?? 4)
          delay(seconds: 2) {
          self.getDriverLastLocation()
          }
          self.driverStatus =  self.objSocket?.driver_status ?? 4
          self.setUI()
          */
         }
         */
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotification()
        
    }
    func registerTableXib(){
        self.tblServicesList.allowsMultipleSelection = true
        //self.tblDetailList.allowsSelection = false
        self.tblServicesList.register(UINib(nibName: "ServicesListTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesListTableViewCell")
        self.tblDriverList.register(UINib(nibName: "DriverListTableViewCell", bundle: nil), forCellReuseIdentifier: "DriverListTableViewCell")
        self.tblReasons.register(UINib(nibName: "TextWithCheckboxTableViewCell", bundle: nil), forCellReuseIdentifier: "TextWithCheckboxTableViewCell")
        self.clcTags.register(UINib(nibName: "TagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagsCollectionViewCell")
//        self.tblReasons.register(UINib.init(nibName: "TextWithCheckboxTableViewCell", bundle: nil), forCellReuseIdentifier: "TextWithCheckboxTableViewCell")

        // self.tblDetailList.register(UINib(nibName: "ServicesListTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesListTableViewCell")
        
    }
    
    // MARK: - TIMER
    
    @objc func updateViewTimer() {
        self.stopTimer()
        self.cancelRide()
    }
    func stopTimer(){
        
        if self.timerForRideRequest != nil{
            timerForRideRequest?.invalidate()
            timerForRideRequest = nil
            
        }
        
    }
    
    // MARK: - UI SETUP
    func setUI(){
        guard let obj = self.objBooking else{return}
        self.lblDriverName.text = obj.driver_first_name ?? ""
        self.lblDriverTowType.text = obj.vehicle_name ?? ""
        self.driverRating.setTitle(obj.driver_rating ?? "0.0", for: .normal)

        UtilitiesManager.shared.setImage(url: obj.driver_image ?? "", img: self.imgDriver)
        
    }
    
    //    func setUIForTowFinder(){
    //        guard let source = self.sourceLocation else{return}
    //        self.getAddressFromlatLong(lat: source.latitude, long: source.longitude, lbl: self.lblSourceLocation)
    //    }
    
    func setupMap(){
        
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        guard let location = self.sourceLocation else{return}
        
        //        guard let sourceLat = self.sourceLocation?.latitude else{return}
        //        guard let sourceLng = self.sourceLocation?.longitude else{return}
        self.addMarker(location: location, markerImg: "pin")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            let camera = GMSCameraPosition.camera(withLatitude: Double(location.latitude), longitude: Double(location.longitude), zoom: 17.0)
            self.mapView.animate(to: camera)
        })
        //pin
        
    }
    // MARK: - NOTIFICATION SETUP
    
    func notificationSetup(){
        NotificationCenter.default.addObserver(self, selector: #selector(confirmRequestObserver), name: Notification.Name(Key.notificationKey.CALLAPIFORSERVICES), object: nil)
    }
    func removeNotification(){
        NotificationCenter.default.removeObserver(self, name: Notification.Name(Key.notificationKey.CALLAPIFORSERVICES), object: nil)
        
    }
    
    
    @objc func confirmRequestObserver(){
        var services = [Service]()
        
        
        guard let selectedDriver = selectedDriver else {
            return
        }
        guard let objBooking = objServiceBooking else {
            return
        }
        guard let service = objBooking.data?.bookingRecord?.services else {
            return
        }
        for service in service{
            
            let obj = Service(id: service.id ?? 0, quantity: service.quantity)
            services.append(obj)
        }
        
        let driver = Driver(driverID: selectedDriver.driver_id ?? 0, firstName: "\(selectedDriver.first_name ?? "")", lastName: "\(selectedDriver.last_name ?? "")", email: "\(selectedDriver.email ?? "")", distance: Int(selectedDriver.distance ?? 0.0), distanceFare: selectedDriver.distanceFare ?? 0, serviceFare: selectedDriver.service_fare ?? 0, totalFare: selectedDriver.total_fare ?? 0)
        
        let model = ServiceBookingRequestModel(services: services, driver: driver, bookingID: objBooking.data?.bookingRecord?.id ?? 0)
        
        
        servicesVM.sendServicesRequest(model: model) { data in
            
            self.checkRideStatus(status: .findingTow)
            //self.servicesStatus(status: .waitingDriver)
        }
    }
    
    
    
    // MARK: - GOOOGLE MAP SETUP
    
    
    func addMarker(location:CLLocationCoordinate2D,markerImg:String){
        self.mapView.clear()
        let myMarker = GMSMarker()
        myMarker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        myMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        myMarker.map = self.mapView
        myMarker.icon = UIImage(named: markerImg)
        myMarker.setIconSize(scaledToSize: .init(width: 30, height: 30))
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
            }
        }
    }
    
    
    
    func getService(completion:@escaping () -> ()) {
        servicesVM.getServiceList { data, error in
            //print("rdxr")
            // service = .selectService
            guard let data = data else {
                return
            }
            
            self.serviceList = data
            guard let obj = self.serviceList?.data else{return}
            self.arrSerivces = obj
            
            self.tblServicesList.reloadData()
            self.servicesStatus(status: .selectService)
            completion()
            
        }
    }
    
    func updateLocationoordinates(coordinates:CLLocationCoordinate2D,bearing:Double) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 17.0)
            self.mapView.animate(to: camera)
        })
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        carMarker.position =  coordinates
        //        carMarker.rotation = bearing
        CATransaction.commit()
    }
    
    func addDriverMarker(location:CLLocationCoordinate2D,markerImg:String){
        carMarker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        carMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        carMarker.map = self.mapView
        carMarker.icon = UIImage(named: markerImg)
        carMarker.setIconSize(scaledToSize: .init(width: 30, height: 30))
        
    }
    func getRouteSteps(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D,markerStart:String,markerEnd:String)
    {
        self.mapView.clear()
        
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
            
            guard routes.count > 0 else{
                DispatchQueue.main.async{
                    
                    UtilitiesManager.shared.showAlertWithAction(self, message: "No route found", title: "Ops", buttons: ["Go Back"]) { index in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                return
                
            }
            guard let route = routes[0] as? [String: Any] else {
                
                DispatchQueue.main.async{
                    
                    UtilitiesManager.shared.showAlertWithAction(self, message: "No route found", title: "Ops", buttons: ["Go Back"]) { index in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                return
            }
            
            guard let legs = route["legs"] as? [Any] else {
                return
            }
            guard legs.count > 0 else{return}
            
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
                    
                    self.drawPath(from: polyLineString,markerStart: markerStart,markerEnd: markerEnd,from: source,to: destination)
                }
                
            }
        })
        task.resume()
    }
    
    func drawPath(from polyStr: String,markerStart:String,markerEnd:String,from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        //DispatchQueue.main.async {
        //        self.mapView.clear()
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = .black
        polyline.map = self.mapView // Google MapView
        self.addMarker(location: source, markerImg: markerStart)
        self.addMarker(location: destination, markerImg: markerEnd)
//        guard let savedLocation = UtilitiesManager.shared.retriveServiceLocation() else{return}
//        let s = CLLocationCoordinate2D(latitude: savedLocation.sourceLat, longitude: savedLocation.sourceLng)
//        let d = CLLocationCoordinate2D(latitude: savedLocation.destinationLat, longitude: savedLocation.destinationLng)
        let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: source, coordinate: destination))
        
        DispatchQueue.main.async {
            self.mapView.moveCamera(cameraUpdate)
            let currentZoom = self.mapView.camera.zoom
            self.mapView.animate(toZoom: currentZoom - 1.4)
        }
    }
    // MARK: - SERVICES STATUS
    
    func servicesStatus(status:ServicesType){
        
        self.serviceStatus = status
        
        switch status {
        case .selectService:
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }completion: { _ in
                
                self.viewDriverList.isHidden = true
                self.viewDetail.isHidden = true
                self.viewServiceList.isHidden = false
                self.viewDriver.isHidden = true
                self.viewWaiting.isHidden = true
                
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
                    self.bottomViewTowConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
        case .selectDriver:
            print("")
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }completion: { _ in
                self.viewDriverList.isHidden = false
                self.viewDetail.isHidden = true
                self.viewServiceList.isHidden = true
                self.viewDriver.isHidden = true
                self.viewWaiting.isHidden = true
                
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
                    self.bottomViewTowConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
        case .detail:
            print("")
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }completion: { _ in
                self.viewDriverList.isHidden = true
                self.viewDetail.isHidden = false
                self.viewServiceList.isHidden = true
                self.viewDriver.isHidden = true
                self.viewWaiting.isHidden = true
                
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
                    self.bottomViewTowConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
            /*
             case .waitingDriver:
             UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
             self.bottomViewTowConstraint.constant = -400
             self.view.layoutIfNeeded()
             }completion: { _ in
             self.viewDriverList.isHidden = true
             self.viewDetail.isHidden = true
             self.viewServiceList.isHidden = true
             self.viewDriver.isHidden = true
             self.viewWaiting.isHidden = false
             
             UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
             self.bottomViewTowConstraint.constant = 0
             self.view.layoutIfNeeded()
             }
             }
             
             case .Accept:
             UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
             self.bottomViewTowConstraint.constant = -400
             self.view.layoutIfNeeded()
             }completion: { _ in
             self.viewDriverList.isHidden = true
             self.viewDetail.isHidden = false
             self.viewServiceList.isHidden = true
             self.viewDriver.isHidden = false
             self.viewWaiting.isHidden = true
             
             UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
             self.bottomViewTowConstraint.constant = 0
             self.view.layoutIfNeeded()
             }
             }*/
        }
    }
    
    func checkRideStatus(status:rideStatus){
        stopTimer()
        
        
        switch status {
        case .findingTow:
            /*
             self.drawLineStatus = 0
             
             //self.btnBack.isHidden = true
             //if self.bottomViewTowConstraint.constant == 0{
             
             UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
             self.bottomViewTowConstraint.constant = -400
             self.view.layoutIfNeeded()
             }
             completion: { _ in
             //self.viewLoaderInFindingTow.pulsate(animationDuration: 1.0)
             
             //self.viewTowList.isHidden = true
             
             /*
              self.viewLoaderInFindingTow.isHidden = false
              */
             UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
             self.bottomViewTowConstraint.constant = 0
             self.view.layoutIfNeeded()
             }completion: { _ in
             self.timerForRideRequest = Timer.scheduledTimer(timeInterval: 90, target: self, selector: #selector(self.updateViewTimer), userInfo: nil, repeats: true)
             
             //                delay(seconds: 5) {
             //                    //self.checkRideStatus(status:.requestAccept)
             //                }
             }
             // self.viewLoaderInFindingTow.pulsate(animationDuration: 1.0)
             
             }
             //            }
             //            else{
             //                self.viewLoaderInFindingTow.isHidden = false
             //            }
             print("resetMap")
             
             */
            self.drawLineStatus = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }completion: { _ in
                self.viewDriverList.isHidden = true
                self.viewDetail.isHidden = true
                self.viewServiceList.isHidden = true
                self.viewDriver.isHidden = true
                self.viewWaiting.isHidden = false
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                    self.bottomViewTowConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }completion: { _ in
                    self.timerForRideRequest = Timer.scheduledTimer(timeInterval: 90, target: self, selector: #selector(self.updateViewTimer), userInfo: nil, repeats: true)
                }
            }
            
        case .requestAccept:
            print("resetMap")
            self.drawLineStatus = 0
            
            self.btnBack.isHidden = true
            
            let fcm = UtilitiesManager.shared.getFcmToken()
            if let bookingId = self.objBooking?.id
            {
                Database.database().reference().child("\(bookingId)").child("fcm").child("fcm1").setValue(fcm)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }completion: { _ in
                
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    self.bottomViewTowConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }completion: { _ in
                    self.setUI()

                    self.viewDriverList.isHidden = true
                    self.viewDetail.isHidden = false
                    self.viewServiceList.isHidden = true
                    self.viewDriver.isHidden = false
                    self.viewWaiting.isHidden = true
                    /*
                     self.viewLoaderInFindingTow.isHidden = true
                     self.viewDriverDetailTow.isHidden = false
                     */
                    self.lblDriverRideStatus.text = "Waiting for driver to reach"
                }
            }
            
        case .requestReject:
            print("resetMap")
            self.drawLineStatus = 0
            self.btnBack.isHidden = false
            
            guard let savedLocation = UtilitiesManager.shared.retriveServiceLocation() else{return}
            let source = CLLocationCoordinate2D(latitude: savedLocation.sourceLat, longitude: savedLocation.sourceLng)
            
            self.getService{
                self.viewWaiting.isHidden = true
                self.viewDriver.isHidden = true
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    self.bottomViewTowConstraint.constant = -400
                    self.view.layoutIfNeeded()
                }completion: { _ in
                    UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
                        self.bottomViewTowConstraint.constant = 0
                        self.view.layoutIfNeeded()
                    }
                    self.addMarker(location: source, markerImg: "pin")
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                        let camera = GMSCameraPosition.camera(withLatitude: Double(source.latitude), longitude: Double(source.longitude), zoom: 17.0)
                        self.mapView.animate(to: camera)
                    })
                }
            }
            /*
             mainMapVm.fetchTowList { data,error  in
             if error == nil {
             guard let datta = data else{return}
             /*
              self.objTowList = datta
              self.tblTowList.reloadData()
              self.viewLoaderInFindingTow.isHidden = true
              self.viewDriverDetailTow.isHidden = true
              */
             //                self.viewTowList.isHidden = false
             UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
             self.bottomViewTowConstraint.constant = -400
             self.view.layoutIfNeeded()
             }completion: { _ in
             UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
             self.bottomViewTowConstraint.constant = 0
             self.view.layoutIfNeeded()
             }
             // if let source = self.sourceLocation,let destination = self.destinationLocation{
             /*
              self.getRouteSteps(from: s, to: d,markerStart: "circle",markerEnd: "square")
              */
             //}
             
             }
             }else{
             
             UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
             self.bottomViewTowConstraint.constant = -400
             self.view.layoutIfNeeded()
             }
             }
             
             
             }
             */
        case .reach:
            print("change dirction from driver to destination")
            self.drawLineStatus = 0
            let fcm = UtilitiesManager.shared.getFcmToken()
            
            if let bookingId = self.objBooking?.id
            {
                Database.database().reference().child("\(bookingId)").child("fcm").child("fcm1").setValue(fcm)
            }
            self.btnBack.isHidden = true
            self.lblDriverRideStatus.text = "Arrived at your destination"
            //            self.viewLoaderInFindingTow.isHidden = true
            //            self.viewDriverDetailTow.isHidden = false
            
            self.viewWaiting.isHidden = true
            self.viewDriver.isHidden = false
//            self.btnCancelServices.isHidden = false

            // if self.bottomViewTowConstraint.constant == 0{
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }
        completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
                self.bottomViewTowConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
            
        case .start:
            print("start tracking")
            self.drawLineStatus = 0
            
            self.btnBack.isHidden = true
            
            self.lblDriverRideStatus.text = "Providing services"
            self.viewWaiting.isHidden = true
            self.viewDriver.isHidden = false
            self.btnCancelServices.isHidden = true
            //            self.viewTowList.isHidden = false
            
            let fcm = UtilitiesManager.shared.getFcmToken()
            if let bookingId = self.objBooking?.id
            {
                Database.database().reference().child("\(bookingId)").child("fcm").child("fcm1").setValue(fcm)
            }
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }
        completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
                self.bottomViewTowConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
            
        case .end:
            print("move to review screen")
            self.drawLineStatus = 0
            
            self.btnBack.isHidden = true
            
            let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "AmountToPayVC") as! AmountToPayVC
            
            vc.booking = self.objBooking
            
            // print("move to review screen")
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .notFound:
            print("resetMap")
            
            self.btnBack.isHidden = false
            
            //            guard let savedLocation = UtilitiesManager.shared.retriveTripLocation() else{return}
            //            let s = CLLocationCoordinate2D(latitude: savedLocation.sourceLat, longitude: savedLocation.sourceLng)
            //            let d = CLLocationCoordinate2D(latitude: savedLocation.destinationLat, longitude: savedLocation.destinationLng)
            
            //            guard let source = self.sourceLocation,let destination = self.destinationLocation else{
            //              return
            //            }
            
            
            guard let savedLocation = UtilitiesManager.shared.retriveServiceLocation() else{return}
            let source = CLLocationCoordinate2D(latitude: savedLocation.sourceLat, longitude: savedLocation.sourceLng)
            self.addMarker(location: source, markerImg: "pin")
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                let camera = GMSCameraPosition.camera(withLatitude: Double(source.latitude), longitude: Double(source.longitude), zoom: 17.0)
                self.mapView.animate(to: camera)
            })
            self.getService{
                self.viewWaiting.isHidden = true
                self.viewDriver.isHidden = true
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    self.bottomViewTowConstraint.constant = -400
                    self.view.layoutIfNeeded()
                }completion: { _ in
                    UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
                        self.bottomViewTowConstraint.constant = 0
                        self.view.layoutIfNeeded()
                    }
                    self.addMarker(location: source, markerImg: "pin")
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                        let camera = GMSCameraPosition.camera(withLatitude: Double(source.latitude), longitude: Double(source.longitude), zoom: 17.0)
                        self.mapView.animate(to: camera)
                    })
                }
            }
            
            /*
             mainMapVm.fetchTowList { data,error  in
             if error == nil {
             guard let datta = data else{return}
             /*
              self.objTowList = datta
              self.tblTowList.reloadData()
              self.viewLoaderInFindingTow.isHidden = true
              self.viewDriverDetailTow.isHidden = true
              */
             //                self.viewTowList.isHidden = false
             UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
             self.bottomViewTowConstraint.constant = -400
             self.view.layoutIfNeeded()
             }completion: { _ in
             UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
             self.bottomViewTowConstraint.constant = 0
             self.view.layoutIfNeeded()
             }
             // if let source = self.sourceLocation,let destination = self.destinationLocation{
             /*
              self.getRouteSteps(from: s, to: d,markerStart: "circle",markerEnd: "square")
              */
             //}
             
             }
             }else{
             
             UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
             self.bottomViewTowConstraint.constant = -400
             self.view.layoutIfNeeded()
             }
             }
             
             
             }
             */
            
        case .rideRejectDuringRide:
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.moveToTabbarVC()
            
        }
        
    }
    
    func checkDriverStatus(driverStatus:Int){
        
        switch driverStatus{
        case 0:
            print("0")
            checkRideStatus(status: .requestAccept)
            
        case 1:
            print("1")
            checkRideStatus(status: .reach)
            
        case 2:
            print("2")
            
            checkRideStatus(status: .start)
            
        case 3:
            print("3")
            checkRideStatus(status: .end)
            //SocketIOManager.sharedInstance.closeConnection()
        case 4:
            checkRideStatus(status: .end)
            
        default:
            print("nothing")
            //checkRideStatus(status: .notFound)
        }
        
    }
    
    func checkDriverStatusForPolyLine(driverStatus:Int){
        
        switch driverStatus{
        case 0:
            print("0")
            switch drawLineStatus{
            case 0:
                print("")
            case 1:
                print("drawLine")
                let pickUp = CLLocationCoordinate2D(latitude: Double(self.objBooking?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.pick_up_longitude ?? "0.0") ?? 0.0)
                self.getRouteSteps(from: pickUp, to: self.driverLocation,markerStart: "circle",markerEnd: "pin")
            case 2:
                print("add marker")
                self.mapView.clear()
                
                let pickUp = CLLocationCoordinate2D(latitude: Double(self.objBooking?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.pick_up_longitude ?? "0.0") ?? 0.0)
                self.addDriverMarker(location: self.driverLocation, markerImg: "pin")
                self.addMarker(location: pickUp, markerImg: "circle")
            case 3:
                print("start tracking")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
            default:
                print("nothing")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
            }
            
        case 1:
            print("1")
            switch drawLineStatus{
            case 0:
                print("")
            case 1:
                print("drawLine")
                let pickUp = CLLocationCoordinate2D(latitude: Double(self.objBooking?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.pick_up_longitude ?? "0.0") ?? 0.0)
                self.getRouteSteps(from: pickUp, to: self.driverLocation,markerStart: "circle",markerEnd: "pin")
            case 2:
                print("add marker")
                self.mapView.clear()
                
                let pickUp = CLLocationCoordinate2D(latitude: Double(self.objBooking?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.pick_up_longitude ?? "0.0") ?? 0.0)
                self.addDriverMarker(location: self.driverLocation, markerImg: "pin")
                self.addMarker(location: pickUp, markerImg: "circle")
            case 3:
                print("start tracking")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
            default:
                print("nothing")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
            }
            /*
             switch drawLineStatus{
             
             case 0:
             print("")
             case 1:
             print("drawLine")
             //                let dropOff = CLLocationCoordinate2D(latitude: Double(self.objBooking?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.drop_off_longitude ?? "0.0") ?? 0.0)
             //                self.getRouteSteps(from: self.driverLocation, to: dropOff,markerStart: "pin",markerEnd: "square")
             self.mapView.clear()
             
             self.addDriverMarker(location: self.driverLocation, markerImg: "pin")
             //                self.addMarker(location: dropOff, markerImg: "square")
             
             case 2:
             print("add marker")
             self.mapView.clear()
             //                let dropOff = CLLocationCoordinate2D(latitude: Double(self.objBooking?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.drop_off_longitude ?? "0.0") ?? 0.0)
             self.addDriverMarker(location: self.driverLocation, markerImg: "pin")
             //                self.addMarker(location: dropOff, markerImg: "square")
             
             case 3:
             print("start tracking")
             self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
             
             default:
             print("nothing")
             self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
             }
             */
        case 2:
            print("2")
            
            //            checkRideStatus(status: .start)
            /*
             if self.getLocation == false {
             self.mapView.clear()
             let dropOff = CLLocationCoordinate2D(latitude: Double(self.objSocket?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.drop_off_longitude ?? "0.0") ?? 0.0)
             self.addMarker(location: dropOff, markerImg: "square")
             self.addDriverMarker(location: self.driverLocation, markerImg: "car_map")
             self.getLocation = true
             }else{
             self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
             }
             */
            
            /*
             switch drawLineStatus{
             case 0:
             print("")
             
             case 1:
             print("drawLine")
             let dropOff = CLLocationCoordinate2D(latitude: Double(self.objBooking?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.drop_off_longitude ?? "0.0") ?? 0.0)
             //self.getRouteSteps(from: self.driverLocation, to: dropOff,markerStart: "pin",markerEnd: "square")
             case 2:
             print("add marker")
             self.mapView.clear()
             let dropOff = CLLocationCoordinate2D(latitude: Double(self.objBooking?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.drop_off_longitude ?? "0.0") ?? 0.0)
             self.addDriverMarker(location: self.driverLocation, markerImg: "pin")
             self.addMarker(location: dropOff, markerImg: "square")
             
             case 3:
             print("start tracking")
             self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
             
             default:
             print("nothing")
             self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
             
             }
             */
            
            switch drawLineStatus{
            case 0:
                print("")
            case 1:
                print("drawLine")
                let pickUp = CLLocationCoordinate2D(latitude: Double(self.objBooking?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.pick_up_longitude ?? "0.0") ?? 0.0)
                self.getRouteSteps(from: pickUp, to: self.driverLocation,markerStart: "circle",markerEnd: "pin")
            case 2:
                print("add marker")
                self.mapView.clear()
                
                let pickUp = CLLocationCoordinate2D(latitude: Double(self.objBooking?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objBooking?.pick_up_longitude ?? "0.0") ?? 0.0)
                self.addDriverMarker(location: self.driverLocation, markerImg: "pin")
                self.addMarker(location: pickUp, markerImg: "circle")
            case 3:
                print("start tracking")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
            default:
                print("nothing")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
            }
        case 3:
            print("3")
            //            checkRideStatus(status: .end)
            // SocketIOManager.sharedInstance.closeConnection()
            
        default:
            print("nothing")
            //checkRideStatus(status: .notFound)
        }
        
    }
    func cancelRide(){
        stopTimer()
        self.reasonVm.bookingId = self.objBooking?.id ?? 0
        self.reasonVm.reasonId = 9
        self.reasonVm.reason = "rider not picked"
        self.reasonVm.callCancelRideApi {
            self.drawLineStatus = 0
            guard self.objBooking != nil else{
                // self.checkRideStatus(status: .notFound)
                return
            }
            //self.checkRideStatus(status: .requestReject)
            
        }
    }
    // MARK: - SOCKETS
    
    func addSocketListerForDriverLastLocation(){
        //listener: passeger_id-driverLastLocation
        
        socket!.on("\(UtilitiesManager.shared.getId())-driverLastLocation") { (data, ack) in
            print("getDriverLastLocation",(UtilitiesManager.shared.getId()))
            
            guard let dataInfo = data.first as? [String:Any] else { return }
            if dataInfo["data"] as? [String:Any] != nil{
                let dict = dataInfo["data"] as? [String:Any]
                let lat = dict?["latitude"] as? Double
                let lng = dict?["longitude"] as? Double
                let bearing = "\(dict?["bearing"] ?? "")"
                
                let location = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lng ?? 0.0)
                
                self.driverLocation = location
                //                self.bearing = Double(bearing) ?? 90.0
                if self.drawLineStatus == 0{
                    self.drawLineStatus = self.drawLineStatus + 1
                    self.checkDriverStatusForPolyLine(driverStatus: self.driverStatus)
                    delay(seconds: 6.0) {
                        self.addSocketListnerForLocation()
                    }
                }
                
                
            }else{
            }
            
            
        }
    }
    
    func addSocketListerForRide(){
        
        
        socket!.on("\(UtilitiesManager.shared.getId())-driverStatus") { (data, ack) in
            print("getDriverStatus",(UtilitiesManager.shared.getId()))
            // self.drawLineStatus = 0
            guard let dataInfo = data.first as? [String:Any] else { return }
            
            if dataInfo["data"] as? [String:Any] != nil
            {
                //self.getLocation = false
                
                self.objBooking = BookingInfo.getRideInfo(dict: dataInfo["data"] as! [String:Any])
                
                if self.objBooking?.driver_status ?? 0 == 0 && self.objBooking?.ride_status ?? 0 == 6{
                    self.checkRideStatus(status: .requestReject)
                }else{
                    self.checkDriverStatus(driverStatus: self.objBooking?.driver_status ?? 0)
                    self.driverStatus = self.objBooking?.driver_status ?? 0
                    
                    self.drawLineStatus = 0
                    self.lblDriverName.text = self.objBooking?.driver_first_name ?? "testing"
                    UtilitiesManager.shared.setImage(url: self.objBooking?.driver_image ?? "", img: self.imgDriver)
                    
                    self.getDriverLastLocation()
                }
                
            }else{
                if dataInfo["message"] as? String != nil{
                    UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: dataInfo["message"] as? String ?? "error getting booking record")
                }
            }
            
            
        }
    }
    func addSocketListnerForLocation(){
        
        socket!.on("\(UtilitiesManager.shared.getId())-driverCoordinate") { (data, ack) in
            
            print("getDriverCordinates",(UtilitiesManager.shared.getId()))
            
            guard let dataInfo = data.first as? [String:Any] else { return }
            
            if dataInfo["data"] as? [String:Any] != nil{
                let dict = dataInfo["data"] as? [String:Any]
                let lat = dict?["latitude"] as? Double
                let lng = dict?["longitude"] as? Double
                let bearing = "\(dict?["bearing"] ?? "")"
                
                let location = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lng ?? 0.0)
                
                self.driverLocation = location
                self.bearing = Double(bearing) ?? 90.0
                print("drawLineStatus",self.drawLineStatus)
                
                if self.drawLineStatus > 0{
                    self.drawLineStatus = self.drawLineStatus + 1
                    self.checkDriverStatusForPolyLine(driverStatus: self.driverStatus)
                }
                
            }else{
                if dataInfo["message"] as? String != nil{
                    UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: dataInfo["message"] as? String ?? "error getting booking record")
                    
                }
            }
            
            
        }
    }
    
    
    
    func addSocketListnerRideAcceptReject(){
        
        socket!.on("\(UtilitiesManager.shared.getId())-finalRideStatus") { (data, ack) in
            print("getIdFinal",(UtilitiesManager.shared.getId()))
            
            self.stopTimer()
            
            self.drawLineStatus = 0
            
            guard let dataInfo = data.first as? [String:Any] else { return }
            
            if dataInfo["data"] as? [String:Any] != nil
            {
                // self.getLocation = false
                
                self.objBooking = BookingInfo.getRideInfo(dict: dataInfo["data"] as! [String:Any])
                
                if self.objBooking?.driver_status ?? 0 == 0 && self.objBooking?.ride_status ?? 0 == 6{
                    
                    self.checkRideStatus(status: .requestReject)
                }else{
                    
                    self.checkDriverStatus(driverStatus: self.objBooking?.driver_status ?? 0)
                    self.getDriverLastLocation()
                }
                
            }else{
                if dataInfo["message"] as? String != nil{
                    UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: dataInfo["message"] as? String ?? "error getting booking record")
                }
            }
        }
    }
    
    
    func getDriverLastLocation() {
        
        let dict = ["user_id":UtilitiesManager.shared.getId(),"booking_id":self.objBooking?.id ?? 0] as [String : Any]
        
        if socket?.status == .notConnected || socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
            getDriverLastLocation()
            return
        }
        socket?.emit("driver-last-location", dict, completion: {
            print("data added for last location")
            self.addSocketListerForDriverLastLocation()
            
        })
        
        
    }
    
    
    // MARK: - BUTTON ACTION
    
    
    @IBAction func btnBackAction(_ sender:Any){
        
        switch serviceStatus {
        case .selectService:
            self.navigationController?.popViewController(animated: true)
        case .selectDriver:
            self.servicesStatus(status: .selectService)
        case .detail:
            self.servicesStatus(status: .selectDriver)
            /*
             case .waitingDriver:
             self.navigationController?.popViewController(animated: true)
             case .Accept:
             self.navigationController?.popViewController(animated: true)
             */
        }
    }
    
    @IBAction func btnNextToDriverAction(_ sender:Any){
        
        
        var services = [SelectedServices]()
        
        for service in arrSelectedSerivces{
            
            let obj = SelectedServices(id: service.id, quantity: service.quantity)
            services.append(obj)
        }
        
        let pickupLat = self.sourceLocation?.latitude ?? 0.0
        let pickupLng = self.sourceLocation?.longitude ?? 0.0
        
        let model = ServiceBookingModel(services: services, pick_up_area: self.PickupArea, pick_up_lat: pickupLat, pick_up_lng: pickupLng)
        
        
        servicesVM.createServiceBooking(model: model) { data in
            
            self.objServiceBooking = data
            DispatchQueue.main.async {
                self.tblDriverList.reloadData()
            }
            self.servicesStatus(status: .selectDriver)
        }
        
        
        
    }
    @IBAction func btnNextToDetailAction(_ sender:Any){
        
        
        guard let obj = self.selectedDriver else{return}
        self.lblName.text = obj.first_name ?? ""
        self.lblPrice.text = "\(obj.total_fare ?? 0)$"
        if let distance = obj.distance {
            self.lblTime.text = "\(distance.rounded(digits: 1))KM"

        }else{
            self.lblTime.text = "\(0.0)KM"
        }
//        self.lblTime.text = "\(obj.distance?.rounded(digits: 1) ?? 0.0)KM"
        
        
        //        guard let services = obj.service else{return}
        //arrSelectedSerivces
        //        guard let services = arrSelectedSerivces else{return}
        guard arrSerivces.count > 0 else{return}
        self.lblService.text = getRequestedServices(arr: arrSelectedSerivces)
        
        servicesStatus(status: .detail)
        
        
    }
    @IBAction func btnConfirmBookingAction(_ sender:Any){
        print("confirm booking")
        guard let _ = self.bookingStatus?.data?.passenger?.stripe_customer_id else {
            UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: "Please add payment method for using tow services")
            return}
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingConfirmationVC") as! BookingConfirmationVC
        vc.type = .services
        self.present(vc, animated: false)
        
    }
    @IBAction func btnCancelRideAction(_ sender:Any){
        /*
        print("button Cancel click")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReasonVC") as! ReasonVC
        vc.booking = self.objBooking
        self.present(vc, animated: false)
        */
        self.viewMain.isHidden = false
        self.viewReason.isHidden = false

        
    }
    @IBAction func btnChatAction(_ sender:Any){
        let vc = UtilitiesManager.shared.getMainStoryboard().instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.booking = self.objBooking
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnCancelServiceAction(_ sender:Any){
        /*
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReasonVC") as! ReasonVC
        //vc.booking = self.objSocket
        self.present(vc, animated: false)
        */
        self.viewMain.isHidden = false
        self.viewReason.isHidden = false

    }
    @IBAction func btnCallAction(_ sender:Any){
        
        guard let data = self.objBooking else{return}
        self.mainMapVm.dialNumber(number: data.driver_mobile_no ?? "")
        
    }
    
    @IBAction func btnConfirmCancelRideAction(_ sender : Any){
//        self.dismiss(animated: false)
        guard let _ = reasonDict else{return}
        self.reasonVm.bookingId = self.objBooking?.id ?? 0
        self.reasonVm.reasonId = reasonDict?.id ?? 0
        self.reasonVm.reason = reasonDict?.text ?? ""
        self.reasonVm.callCancelRideApi {
            self.viewMain.isHidden = true
            self.viewReason.isHidden = true
            self.stopTimer()
            self.drawLineStatus = 0
            guard self.objBooking != nil else{
                self.checkRideStatus(status: .notFound)
                return
            }
            self.checkRideStatus(status: .rideRejectDuringRide)

        }

    }
}

// MARK: - UITABLEVIEW DELEGATES


extension ServicesMapVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblServicesList{
            return self.arrSerivces.count
        }else if tableView == self.tblDriverList{
            guard let data = self.objServiceBooking?.data?.driverList else{return 0}
            return data.count
        }else{
            return dataSource?.count ?? 0
            //return arrSelectedSerivces.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tblServicesList{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesListTableViewCell", for: indexPath) as! ServicesListTableViewCell
            

//            guard let obj = self.serviceList?.data else{return cell}
            cell.obj = self.arrSerivces[indexPath.row]
            cell.btnPlus.tag = indexPath.row
            cell.btnMinus.tag = indexPath.row
            cell.btnPlus.addTarget(self, action: #selector(addQuantityPressed), for: .touchUpInside)
            cell.btnMinus.addTarget(self, action: #selector(minusQuantityPressed), for: .touchUpInside)

            
            return cell
        }else if tableView == self.tblDriverList{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DriverListTableViewCell", for: indexPath) as! DriverListTableViewCell
            guard let data = self.objServiceBooking?.data?.driverList else{return cell}
            cell.obj = data[indexPath.row]
            //guard let obj = self.serviceList?.data else{return cell}
    //        cell.obj = obj[indexPath.row]
            return cell
        }else{
            /*
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesListTableViewCell", for: indexPath) as! ServicesListTableViewCell
           // guard let obj = self.serviceList?.data else{return cell}
            cell.obj = arrSelectedSerivces[indexPath.row]
            return cell
            */
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextWithCheckboxTableViewCell", for: indexPath) as! TextWithCheckboxTableViewCell
            guard let obj = self.dataSource else {return cell}
            if selectedIndex == indexPath.row{
                cell.imgStatus.image = UIImage.init(named: "check")
            }
            else{
                cell.imgStatus.image = UIImage.init(named: "unCheck")
            }
            cell.setData(data: obj[indexPath.row])
            return cell
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tblServicesList{
            print("tblServicesList")
            let data = self.arrSerivces[indexPath.row]
            self.arrSelectedSerivces.append(data)
            //self.tblDetailList.reloadData()
        }else if tableView == self.tblDriverList{
            print("tblDriverList")
            guard let data = self.objServiceBooking?.data?.driverList else{return}
            self.selectedDriver = data[indexPath.row]
        }else{
            print("detail")
            guard let obj = self.dataSource else {return }
            self.reasonDict = obj[indexPath.row]
            self.selectedIndex = indexPath.row
//            self.btnCancelReason.setTitleColor(UIColor(named: "redText"), for: .normal)
            self.btnCancelReason.backgroundColor = UIColor(named: "redText")
            self.tblReasons.reloadData()
            return

        }
       // guard let obj = self.serviceList?.data else{return}
//        self.objTow = obj[indexPath.row]

        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Desleelelle")
       // guard let obj = self.serviceList?.data else{return}
        let data = self.arrSerivces[indexPath.row]
        if tableView == self.tblServicesList{
            let ind = self.arrSelectedSerivces.firstIndex(where: {$0.id == data.id})
            guard let indexx = ind else{return}
            self.arrSelectedSerivces.remove(at: indexx)
           // self.tblDetailList.reloadData()

        }else if tableView == self.tblDriverList{
            print("tblDriverList")
        }else{
            print("detail")
        }

    }
    
    @objc func addQuantityPressed(_ sender: UIButton)
    {
       // guard let obj = self.serviceList?.data else{return}
        print("plus")

        let objData = self.arrSerivces[sender.tag]
        self.arrSerivces[sender.tag].quantity = objData.quantity + 1
        
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tblServicesList.reloadRows(at: [indexPath], with: .top)

        
        //self.serviceList?.data?[sender.tag].quantity = objData.quantity
        //self.serviceList?.data = objData
//        if quantity < 100
//        {
//
//        }
//        var obj = self.arrCart[sender.tag]
//        let quantity = cartObj.quantity + 1
//        if quantity < 100
//        {
//            cartObj.quantity = quantity
//            self.arrCart[sender.tag] = cartObj
//            CartManager().addProductInCart(arr: self.arrCart)
//            //            CartManager().addProductToCart(product: cartObj)
//            self.updateCartBadgeLbl()
//            // UtilityManager().addHapticFeedback()
//        }
    }
    @objc func minusQuantityPressed(_ sender: UIButton)
    {
        
        print("minus")
//        guard let obj = self.serviceList?.data else{return}
//        var objData = obj[sender.tag]
        let objData = self.arrSerivces[sender.tag]

        guard objData.quantity > 1 else{
            return
        }
        self.arrSerivces[sender.tag].quantity = objData.quantity - 1

        let indexPath = IndexPath(item: sender.tag, section: 0)
        tblServicesList.reloadRows(at: [indexPath], with: .top)

//        var cartObj = self.arrCart[sender.tag]
//        let quantity = cartObj.quantity - 1
//        if quantity > 0
//        {
//            cartObj.quantity = quantity
//            self.arrCart[sender.tag] = cartObj
//            CartManager().addProductInCart(arr: self.arrCart)
//            self.updateCartBadgeLbl()
//        }
    }
    
    
    func getServices(arr:[DriverServices]) -> String{
        var name = ""
        for obj in arr{
            if name.isEmpty{
                name = "\(obj.service_name ?? "")"
            }else{
                name = name+","+"\(obj.service_name ?? "")"
            }
        }
        return name
    }
    
    func getRequestedServices(arr:[Services]) -> String{
        var name = ""
        for obj in arr{
            if name.isEmpty{
                name = "\(obj.name ?? "")"
            }else{
                name = name+","+"\(obj.name ?? "")"
            }
        }
        return name
    }
}

// MARK: - COLLECTIONVIEW_DELEGATES



extension ServicesMapVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrSelectedSerivces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCollectionViewCell", for: indexPath) as! TagsCollectionViewCell
        let obj = self.arrSelectedSerivces[indexPath.row]
        cell.lblTitle.text = obj.name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        //        let item =  searching ? self.filterArray[indexPath.row].caption : self.arrTags[indexPath.row].caption
        guard let item =  self.arrSelectedSerivces[indexPath.row].name else{return CGSize(width: 10, height: 10)}
        
        // return CGSize(width: label.frame.width, height: 30)
        return CGSize(width: item.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 25, height: 30)
        
        //return collectionViewSize
        
    }
    
}
