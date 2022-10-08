//
//  MainMapVC.swift
//  Towy
//
//  Created by Usman on 05/09/2022.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SocketIO
import SwiftyJSON
import Alamofire
import CoreLocation
class MainMapVC: UIViewController,GMSMapViewDelegate {
    
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
    
    
    @IBOutlet weak var tblTowList:UITableView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var bottomViewTowConstraint: NSLayoutConstraint!
    //    @IBOutlet weak var bottomViewFindingConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewLoaderInFindingTow: UIView!
    @IBOutlet weak var viewDriverDetailTow: UIView!
    
    @IBOutlet weak var viewTowList: UIView!
    
    //  @IBOutlet weak var bottomViewConfirmingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnConfirm:UIButton!
    
    
    @IBOutlet weak var imgDriver:UIImageView!
    @IBOutlet weak var lblDriverName:UILabel!
    @IBOutlet weak var lblDriverRideStatus:UILabel!
    @IBOutlet weak var lblDriverTowType:UILabel!
    
    @IBOutlet weak var lblDestination:UILabel!
    @IBOutlet weak var lblSource:UILabel!

    
    var currentLocation = CLLocationCoordinate2D()
    
    var sourceLocation  : CLLocationCoordinate2D? = nil
    
    var destinationLocation : CLLocationCoordinate2D? = nil
    
    var driverLocation = CLLocationCoordinate2D()
    var bearing = 90.0
    //    var driverFirstTimeLocation = CLLocationCoordinate2D()
    //    var driverFirstTimeLocation = CLLocationCoordinate2D()
    
    var getLocation = false
    
//    var strDestination = ""
    private let manager = CLLocationManager()
    
    var objTowList :TowListModel? = nil
    //    var objBooking : BookingStatusCheckModel? = nil
    var objSocket:BookingInfo? = nil
    
    
    var objTow :TowDatum? = nil
    
    var mainMapVm = MainMapVM()
    // let socket = SocketIOManager.sharedInstance.socket
    
    var statusForRide = rideStatus.findingTow
    
    var isConnectedToSocket = false
    
    let socket = SocketIOManager.sharedInstance.socket
    
    
    var carMarker = GMSMarker()
    
    
    var driverStatus = 0
    var drawLineStatus = 0
    //var driverMaker = GMSMarker()

    
    var timerForRideRequest:Timer!
    var reasonVm = ReasonVM()

    //    @IBOutlet weak var tblTowList:UITableView!
    //    @IBOutlet weak var tblTowList:UITableView!
    //    @IBOutlet weak var tblTowList:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.timerForRideRequest = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateViewTimer), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
        registerTableXib()
        self.tabBarController?.tabBar.isHidden = true
        notificationSetup()
        if let source = self.sourceLocation,let destination = self.destinationLocation{
            mainMapVm.sourceLocation = source
            mainMapVm.destinationLocation = destination
            mainMapVm.getAddress(userLocation: CLLocation(latitude: destination.latitude, longitude: destination.longitude))
            let obj = UserTripLocationModel(sourceLat: source.latitude, sourceLng: source.longitude, destinationLat: destination.latitude, destinationLng: destination.longitude)
            UtilitiesManager.shared.saveUserTripLocation(user: obj)
        }
        //        self.lblDestination.text = self.strDestination
        setupMap()
        setUIForTowFinder()
        //        SocketHelper.shared.connectSocket { (success) in
        //        }
        if socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
        }
        addSocketListerForRide()
        // addSocketListnerForLocation()
        addSocketListnerRideAcceptReject()
        //addSocketListerForDriverLastLocation()
        
        // self.checkRideStatus(status: .notFound)
        //socketInit()
        /*
         guard objSocket != nil else{
         self.checkRideStatus(status: .notFound)
         return
         }
         self.checkDriverStatus(driverStatus: self.objSocket?.driver_status ?? 4)
         delay(seconds: 2) {
         self.getDriverLastLocation()
         }
         self.driverStatus =  self.objSocket?.driver_status ?? 4
         setUI()
         */
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        mainMapVm.getBookingStatus { bookingData,error  in
            guard error == nil else{return}
            
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
            self.objSocket = b
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
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    @objc func updateViewTimer() {
        self.stopTimer()
        self.cancelRide()
    }
    func setUI(){
        guard let obj = self.objSocket else{return}
        self.lblDriverName.text = obj.driver_first_name ?? ""
        self.lblDriverTowType.text = obj.vehicle_name ?? ""
        UtilitiesManager.shared.setImage(url: obj.driver_image ?? "", img: self.imgDriver)
        
    }
    func setUIForTowFinder(){
        guard let source = self.sourceLocation else{return}
        guard let destination = self.destinationLocation else{return}

        self.getAddressFromlatLong(lat: source.latitude, long: source.longitude, lbl: self.lblSource)
        self.getAddressFromlatLong(lat: destination.latitude, long: destination.longitude, lbl: self.lblDestination)

    }
    func addSocketListerForDriverLastLocation(){
        //listener: passeger_id-driverLastLocation
        
        socket!.on("\(UtilitiesManager.shared.getId())-driverLastLocation") { (data, ack) in
            print("getDriverLastLocation",(UtilitiesManager.shared.getId()))
            
            guard let dataInfo = data.first as? [String:Any] else { return }
            /*
             [{
             data =     {
             "area_name" = "area_name";
             bearing = 90;
             city = city;
             latitude = "31.500655831446";
             longitude = "74.270240753883";
             };
             message = "Driver Last Coordinate";
             result = success;
             }]
             */
            
            if dataInfo["data"] as? [String:Any] != nil{
                let dict = dataInfo["data"] as? [String:Any]
                let lat = dict?["latitude"] as? Double
                let lng = dict?["longitude"] as? Double
                let bearing = "\(dict?["bearing"] ?? "")"
                
                //                let area_name = "\(dict?["area_name"])"
                //                let city = "\(dict?["city"])"
                let location = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lng ?? 0.0)
                self.driverLocation = location
                self.bearing = Double(bearing) ?? 90.0
                if self.drawLineStatus == 0{
                    self.drawLineStatus = self.drawLineStatus + 1
                    self.checkDriverStatusForPolyLine(driverStatus: self.driverStatus)
                    delay(seconds: 6.0) {
                        self.addSocketListnerForLocation()
                    }
                }
                //                    print("drawLineStatus",self.drawLineStatus)
                
                //delay(seconds: 5.0) {
                
                //                    if self.drawLineStatus < 4 {
                //                        self.drawLineStatus = self.drawLineStatus + 1
                //                    }
                //
                //                    self.checkDriverStatusForPolyLine(driverStatus: self.driverStatus)
                
                //}
                
            }else{
                //                if dataInfo["message"] as? String != nil{
                //                    UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: dataInfo["message"] as? String ?? "error getting booking record")
                //                }
            }
            
            
        }
    }
    
    func addSocketListerForRide(){
        
        //SocketHelper.Events.listnerName
        /*
         SocketHelper.Events.driverStatus.listen { [weak self] (result) in
         print("resultStatus",result)
         }
         */
        
        socket!.on("\(UtilitiesManager.shared.getId())-driverStatus") { (data, ack) in
            print("getDriverStatus",(UtilitiesManager.shared.getId()))
            self.drawLineStatus = 0
            guard let dataInfo = data.first as? [String:Any] else { return }
            
            if dataInfo["data"] as? [String:Any] != nil
            {
                //self.getLocation = false
                self.objSocket = BookingInfo.getRideInfo(dict: dataInfo["data"] as! [String:Any])
                
                if self.objSocket?.driver_status ?? 0 == 0 && self.objSocket?.ride_status ?? 0 == 6{
                    self.checkRideStatus(status: .requestReject)
                }else{
                    self.checkDriverStatus(driverStatus: self.objSocket?.driver_status ?? 0)
                    self.driverStatus = self.objSocket?.driver_status ?? 0
                    
                    self.drawLineStatus = 0
                    self.lblDriverName.text = self.objSocket?.driver_first_name ?? "testing"
                    UtilitiesManager.shared.setImage(url: self.objSocket?.driver_image ?? "", img: self.imgDriver)
//                    self.lblDriverName.text = self.objSocket?.driver_first_name ?? "testing"

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
        
        /*
         SocketHelper.Events.driverCoordinate.listen { [weak self] (result) in
         print("resultCordinate",result)
         }
         */
        
        socket!.on("\(UtilitiesManager.shared.getId())-driverCoordinate") { (data, ack) in
            
            print("getDriverCordinates",(UtilitiesManager.shared.getId()))
            
            guard let dataInfo = data.first as? [String:Any] else { return }
            
            if dataInfo["data"] as? [String:Any] != nil{
                let dict = dataInfo["data"] as? [String:Any]
                let lat = dict?["latitude"] as? Double
                let lng = dict?["longitude"] as? Double
                let bearing = "\(dict?["bearing"] ?? "")"
                
                //                let area_name = "\(dict?["area_name"])"
                //                let city = "\(dict?["city"])"
                let location = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lng ?? 0.0)
                self.driverLocation = location
                self.bearing = Double(bearing) ?? 90.0
                print("drawLineStatus",self.drawLineStatus)
                
                //delay(seconds: 5.0) {
                
                //                if self.drawLineStatus < 4 {
                //                    self.drawLineStatus = self.drawLineStatus + 1
                //                }
                if self.drawLineStatus > 0{
                    self.drawLineStatus = self.drawLineStatus + 1
                    self.checkDriverStatusForPolyLine(driverStatus: self.driverStatus)
                }
                
                //}
                
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
                self.objSocket = BookingInfo.getRideInfo(dict: dataInfo["data"] as! [String:Any])
                if self.objSocket?.driver_status ?? 0 == 0 && self.objSocket?.ride_status ?? 0 == 6{
                    self.checkRideStatus(status: .requestReject)
                }else{
                    self.checkDriverStatus(driverStatus: self.objSocket?.driver_status ?? 0)
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
        
        let dict = ["user_id":UtilitiesManager.shared.getId(),"booking_id":self.objSocket?.id ?? 0] as [String : Any]
        
        if socket?.status == .notConnected || socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
            getDriverLastLocation()
            return
        }
        
        //        socket?.emit("point-to-point-tracking", locationDict)
        socket?.emit("driver-last-location", dict, completion: {
            print("data added for last location")
            self.addSocketListerForDriverLastLocation()
            
        })
        
        
    }
    func getDataFrom(JSON json: JSON) -> Data? {
        do {
            return try json.rawData(options: .prettyPrinted)
        } catch _ {
            return nil
        }
    }
    
    func getJSONFrom(Data data: Data) -> JSON? {
        do {
            return try JSON(data: data, options: .mutableContainers)
        } catch _ {
            return nil
        }
        
    }
    func registerTableXib(){
        self.tblTowList.register(UINib(nibName: "TowListTableViewCell", bundle: nil), forCellReuseIdentifier: "TowListTableViewCell")
        
    }
    
    // MARK: - NOTIFICATION_OBSERVER
    //    func notificationSetup(){
    //
    //
    //    }
    
    
    func checkDriverStatusForPolyLine(driverStatus:Int){
        
        switch driverStatus{
        case 0:
            print("0")
            //            checkRideStatus(status: .requestAccept)
            
            switch drawLineStatus{
                
                
            case 0:
                print("")
                //                completion()
            case 1:
                print("drawLine")
                let pickUp = CLLocationCoordinate2D(latitude: Double(self.objSocket?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.pick_up_longitude ?? "0.0") ?? 0.0)
                self.getRouteSteps(from: pickUp, to: self.driverLocation,markerStart: "circle",markerEnd: "pin")
            case 2:
                print("add marker")
                self.mapView.clear()
                
                let pickUp = CLLocationCoordinate2D(latitude: Double(self.objSocket?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.pick_up_longitude ?? "0.0") ?? 0.0)
                self.addDriverMarker(location: self.driverLocation, markerImg: "pin")
                self.addMarker(location: pickUp, markerImg: "circle")
                //                completion()
                
            case 3:
                print("start tracking")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
                //                completion()
                
            default:
                print("nothing")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
                //                completion()
                
            }
            
        case 1:
            print("1")
            switch drawLineStatus{
            case 0:
                print("")
                //                completion()
                
            case 1:
                print("drawLine")
                let dropOff = CLLocationCoordinate2D(latitude: Double(self.objSocket?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.drop_off_longitude ?? "0.0") ?? 0.0)
                self.getRouteSteps(from: self.driverLocation, to: dropOff,markerStart: "pin",markerEnd: "square")
            case 2:
                print("add marker")
                self.mapView.clear()
                let dropOff = CLLocationCoordinate2D(latitude: Double(self.objSocket?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.drop_off_longitude ?? "0.0") ?? 0.0)
                self.addDriverMarker(location: self.driverLocation, markerImg: "pin")
                self.addMarker(location: dropOff, markerImg: "square")
                //                completion()
                
            case 3:
                print("start tracking")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
                //                completion()
                
            default:
                print("nothing")
                self.updateLocationoordinates(coordinates: driverLocation,bearing: self.bearing)
                //                completion()
                
            }
            
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
            
            
            switch drawLineStatus{
            case 0:
                print("")
                
            case 1:
                print("drawLine")
                let dropOff = CLLocationCoordinate2D(latitude: Double(self.objSocket?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.drop_off_longitude ?? "0.0") ?? 0.0)
                self.getRouteSteps(from: self.driverLocation, to: dropOff,markerStart: "pin",markerEnd: "square")
            case 2:
                print("add marker")
                self.mapView.clear()
                let dropOff = CLLocationCoordinate2D(latitude: Double(self.objSocket?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.drop_off_longitude ?? "0.0") ?? 0.0)
                self.addDriverMarker(location: self.driverLocation, markerImg: "pin")
                self.addMarker(location: dropOff, markerImg: "square")
                
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
            
        default:
            print("nothing")
            //checkRideStatus(status: .notFound)
        }
        
    }
    
    func setupMap(){
        
        
        mapView.isMyLocationEnabled = false
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        guard let sourceLat = self.objSocket?.pick_up_latitude else{return}
        guard let sourceLng = self.objSocket?.pick_up_longitude else{return}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            let camera = GMSCameraPosition.camera(withLatitude: Double(sourceLat) ?? 0.0, longitude: Double(sourceLng) ?? 0.0, zoom: 17.0)
            self.mapView.animate(to: camera)
        })
        
    }
    
    
    func checkRideStatus(status:rideStatus){

        
        switch status {
        case .findingTow:
            self.drawLineStatus = 0
            
            self.btnBack.isHidden = true
            //if self.bottomViewTowConstraint.constant == 0{
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }
        completion: { _ in
            //self.viewLoaderInFindingTow.pulsate(animationDuration: 1.0)
            
            //self.viewTowList.isHidden = true
            self.viewLoaderInFindingTow.isHidden = false

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
            
            
        case .requestAccept:
            print("resetMap")
            self.drawLineStatus = 0
            
            self.btnBack.isHidden = true
            // if self.bottomViewTowConstraint.constant == 0{
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }completion: { _ in
                
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    self.bottomViewTowConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }completion: { _ in
                    self.viewLoaderInFindingTow.isHidden = true
                    self.viewDriverDetailTow.isHidden = false
                    self.lblDriverRideStatus.text = "Meet at the pickup point"
                }
            }
            
        case .requestReject:
            print("resetMap")
            self.drawLineStatus = 0
            
            self.btnBack.isHidden = false
            guard let savedLocation = UtilitiesManager.shared.retriveTripLocation() else{return}
            let s = CLLocationCoordinate2D(latitude: savedLocation.sourceLat, longitude: savedLocation.sourceLng)
            let d = CLLocationCoordinate2D(latitude: savedLocation.destinationLat, longitude: savedLocation.destinationLng)
            
            mainMapVm.fetchTowList { data,error  in
                if error == nil {
                    guard let datta = data else{return}
                    self.objTowList = datta
                    self.tblTowList.reloadData()
                    self.viewLoaderInFindingTow.isHidden = true
                    self.viewDriverDetailTow.isHidden = true
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
                        self.getRouteSteps(from: s, to: d,markerStart: "circle",markerEnd: "square")
                        
                        //}
                        
                    }
                }else{
                    
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                        self.bottomViewTowConstraint.constant = -400
                        self.view.layoutIfNeeded()
                    }
                }
           
                
            }
            
        case .reach:
            print("change dirction from driver to destination")
            self.drawLineStatus = 0
            
            self.btnBack.isHidden = true
            self.lblDriverRideStatus.text = "Reached at pickup point"
            self.viewLoaderInFindingTow.isHidden = true
            self.viewDriverDetailTow.isHidden = false
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
            
            self.lblDriverRideStatus.text = "Start towing"
            self.viewLoaderInFindingTow.isHidden = true
            self.viewDriverDetailTow.isHidden = false
            //            self.viewTowList.isHidden = false
            
            
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
            
            vc.booking = self.objSocket
            // print("move to review screen")
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .notFound:
            print("resetMap")
            
            self.btnBack.isHidden = false
            guard let savedLocation = UtilitiesManager.shared.retriveTripLocation() else{return}
            let s = CLLocationCoordinate2D(latitude: savedLocation.sourceLat, longitude: savedLocation.sourceLng)
            let d = CLLocationCoordinate2D(latitude: savedLocation.destinationLat, longitude: savedLocation.destinationLng)
            
            //            guard let source = self.sourceLocation,let destination = self.destinationLocation else{
            //              return
            //            }
            
            mainMapVm.fetchTowList { data,error  in
                if error == nil {
                    guard let datta = data else{return}
                    self.objTowList = datta
                    self.tblTowList.reloadData()
                    self.viewLoaderInFindingTow.isHidden = true
                    self.viewDriverDetailTow.isHidden = true
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
                        self.getRouteSteps(from: s, to: d,markerStart: "circle",markerEnd: "square")
                        
                        //}
                        
                    }
                }else{
                    
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                        self.bottomViewTowConstraint.constant = -400
                        self.view.layoutIfNeeded()
                    }
                }
           
                
            }
            
        case .rideRejectDuringRide:
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.moveToTabbarVC()

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
        carMarker.rotation = bearing
        CATransaction.commit()
    }
    
    
    func stopTimer(){
        if self.timerForRideRequest != nil{
            timerForRideRequest?.invalidate()
            timerForRideRequest = nil
        }
    }
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnConfirmAction(_ sender:Any){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingConfirmationVC") as! BookingConfirmationVC
        self.present(vc, animated: false)
        
    }
    
    @IBAction func btnCancelAction(_ sender:Any){
        
        print("button Cancel click")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReasonVC") as! ReasonVC
        vc.booking = self.objSocket
        self.present(vc, animated: false)
        
    }
    
    @IBAction func btnChatAction(_ sender:Any){
        let vc = UtilitiesManager.shared.getMainStoryboard().instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.booking = self.objSocket
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnCancelServiceAction(_ sender:Any){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReasonVC") as! ReasonVC
        vc.booking = self.objSocket
        self.present(vc, animated: false)
    }
    @IBAction func btnCallAction(_ sender:Any){
        
        guard let data = self.objSocket else{return}
        self.mainMapVm.dialNumber(number: data.driver_mobile_no ?? "")
        
    }
    // MARK: - NOTIFICATION_OBSERVER
    
    func notificationSetup(){
        NotificationCenter.default.addObserver(self, selector: #selector(popControllerObserver), name: Notification.Name(Key.notificationKey.CALLAPIFORBOOKING), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(bookingCancelObserver), name: Notification.Name(Key.notificationKey.UPDATE_UI_FOR_CANCEL), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.appBecomeActive), name:NSNotification.Name(Key.notificationKey.APP_BECOME_ACTIVE) , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.bookingCancelObserver), name:NSNotification.Name(Key.notificationKey.RIDE_CANCEL_BY_DRIVER) , object: nil)

        
    }
    
    func cancelRide(){
        //stopTimer()
        self.reasonVm.bookingId = self.objSocket?.id ?? 0
        self.reasonVm.reasonId = 9
        self.reasonVm.reason = "rider not picked"
        self.reasonVm.callCancelRideApi {
            self.drawLineStatus = 0
            guard self.objSocket != nil else{
                self.checkRideStatus(status: .notFound)
                return
            }
            self.checkRideStatus(status: .requestReject)
            
        }
    }
    @objc func popControllerObserver(){
        
        guard let obj = objTow else{return}
        mainMapVm.sendRequestForBooking(obj: obj) { bookingData in
            print("sucess")
            self.drawLineStatus = 0
            
            let dictionary = try! DictionaryEncoder().encode(bookingData)
            let dict = JSON(dictionary).dictionaryObject
            
            guard let data = dict?["data"] as? [String:Any] else{return}
            
            //            guard let booking = data["booking"] as? [String:Any] else{
            //                return
            //            }
            
            
            let b = BookingInfo.getRideInfo(dict: data)
            
            
            self.objSocket = b
            //self.getDriverLastLocation()
            
            self.checkRideStatus(status: .findingTow)
        }
    }
    @objc func bookingCancelObserver(){
        stopTimer()
        self.drawLineStatus = 0
        guard self.objSocket != nil else{
            self.checkRideStatus(status: .notFound)
            return
        }
        self.checkRideStatus(status: .rideRejectDuringRide)
    }
    
    
    @objc func reasonObserver(){
        self.drawLineStatus = 0
        checkRideStatus(status: .requestReject)
        //        guard let obj = objTow else{return}
        //        mainMapVm.sendRequestForBooking(obj: obj) { success in
        //            print("sucess")
        //            self.checkRideStatus(status: .findingTow)
        //        }
    }
    
    
    @objc func appBecomeActive(){
        
        viewWillAppear(false)
    }
    
    @objc func rideCancelByUser(){
        
    }
    // MARK: - MAPS_SETTING
    
    
    
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
    
    //MARK:- Draw Path line
    
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
        guard let savedLocation = UtilitiesManager.shared.retriveTripLocation() else{return}
        let s = CLLocationCoordinate2D(latitude: savedLocation.sourceLat, longitude: savedLocation.sourceLng)
        let d = CLLocationCoordinate2D(latitude: savedLocation.destinationLat, longitude: savedLocation.destinationLng)
        let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: s, coordinate: d))
        
        DispatchQueue.main.async {
            self.mapView.moveCamera(cameraUpdate)
            let currentZoom = self.mapView.camera.zoom
            self.mapView.animate(toZoom: currentZoom - 1.4)
        }
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
    func addDriverMarker(location:CLLocationCoordinate2D,markerImg:String){
        carMarker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        carMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        carMarker.map = self.mapView
        carMarker.icon = UIImage(named: markerImg)
        carMarker.setIconSize(scaledToSize: .init(width: 30, height: 30))
        
    }
    
    
    
    
    
    // MARK: - BUTTON ACTION
    
    @IBAction func btnConfirmTow(_ sender:Any){
        guard let obj = self.objTow else{return}
        mainMapVm.sendRequestForBooking(obj: obj) { data in
            print("data successfully sent")
        }
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
    
}

extension MainMapVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objTowList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TowListTableViewCell", for: indexPath) as! TowListTableViewCell
        guard let obj = self.objTowList else{return cell}
        cell.obj = obj.data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect")
        guard let obj = self.objTowList else{return}
        self.objTow = obj.data[indexPath.row]
        self.btnConfirm.setTitle("Confirm \(obj.data[indexPath.row].name ?? "")", for: .normal)
        
    }
}
