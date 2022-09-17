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
class MainMapVC: UIViewController,GMSMapViewDelegate {
    
    enum rideStatus{
        case findingTow
        case requestAccept
        case requestReject
        case reach
        case start
        case end
        case notFound
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
    
    
    var currentLocation = CLLocationCoordinate2D()
    
    var sourceLocation  = CLLocationCoordinate2D()
    
    var destinationLocation = CLLocationCoordinate2D()
    
    var trackingLocation = CLLocationCoordinate2D()

    private let manager = CLLocationManager()
    
    var objTowList :TowListModel? = nil
//    var objBooking : BookingStatusCheckModel? = nil
    var objSocket:BookingInfo? = nil

    
    var objTow :TowDatum? = nil
    
    var mainMapVm = MainMapVM()
   // let socket = SocketIOManager.sharedInstance.socket
    
    var statusForRide = rideStatus.findingTow
    
    var isConnectedToSocket = false

    @IBOutlet weak var imgDriver:UIImageView!
    @IBOutlet weak var lblDriverName:UILabel!
    @IBOutlet weak var lblDriverRideStatus:UILabel!
    @IBOutlet weak var lblDriverTowType:UILabel!
//    @IBOutlet weak var tblTowList:UITableView!
//    @IBOutlet weak var tblTowList:UITableView!
//    @IBOutlet weak var tblTowList:UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableXib()
        self.tabBarController?.tabBar.isHidden = true
        notificationSetup()
        mainMapVm.sourceLocation = self.sourceLocation
        mainMapVm.destinationLocation = self.destinationLocation
        socketInit()

        guard objSocket != nil else{
            self.checkRideStatus(status: .notFound)
            return
        }

        self.checkDriverStatus(driverStatus: self.objSocket?.driver_status ?? 4)
        
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    func socketInit(){
        
        SocketHelper.shared.connectSocket { (success) in

        }
        SocketHelper.Events.accept.listen { [weak self] (result) in
            // print(result[0])
            print("SSSSSOOOOOCCCKKEET_1",result)

        }
        SocketHelper.Events.driverStatus.listen { [weak self] (result) in
            // print(result[0])
            print("SSSSSOOOOOCCCKKEET_2",result)

        }
        
        SocketHelper.Events.pointToPoint.listen { [weak self] (result) in
            // print(result[0])
//            let a = result[0] as! NSDictionary
//            let b = a["area_name"]
            print("SSSSSOOOOOCCCKKEET_3",result)

            guard !result.isEmpty else{return}
            guard let dataInfo = result.first else { return }
            let jsonData = JSON(dataInfo).dictionaryObject
            
            print("SSSSSOOOOOCCCKKEET_3",jsonData)
            print("SSSSSOOOOOCCCKKEET_ttt",JSON(result))

            let dict = jsonData?["data"] as? NSDictionary
            let lat = dict?["latitude"] as? String
            let lng = dict?["longitude"] as? String
            let bearing = "\(dict?["bearing"])"
            let area_name = "\(dict?["area_name"])"
            let city = "\(dict?["city"])"
            
            
            guard lat == nil || lng == nil else{return}
            print("aya aggy",lat,lng)
            
            
            let json = JSON(dataInfo)
            guard let data = self?.getDataFrom(JSON: json) else{return}
            
            if jsonData?["data"] as? [String:Any] != nil{
               let booking = BookingInfo.getRideInfo(dict: jsonData?["data"] as! [String:Any])
                print("booking",booking)
                self?.objSocket = booking
                self?.checkDriverStatus(driverStatus: booking.driver_status ?? 0)
            }
            else{
                print("ni gl bni")
            }
            /*
            do {
                let genericModel = try JSONDecoder().decode(SocketBookingModelElement.self, from: data)
                self?.lblDriverName.text = genericModel.data.driverFirstName ?? ""
                self?.lblDriverTowType.text = genericModel.data.vehicleName ?? "tow"
                self?.objSocket = genericModel
               // self?.lblDriverRideStatus.text = genericModel.message ?? ""

                print("DriverDetail",genericModel.data.driverFirstName)
                self?.checkDriverStatus(driverStatus: genericModel.data.driverStatus ?? 0)
                //try JSONDecoder().decode(BookingStatusCheckModel.self, from: data)
            }
            catch
            {
                print("catch error",String(data: data, encoding: .utf8) ?? "nothing received")
                //completion(.failure(error))
            }
            */
            self?.trackingLocation = CLLocationCoordinate2D(latitude: Double(lat ?? "0.0") ?? 0.0, longitude: Double(lng ?? "0.0") ?? 0.0)
            //self?.checkRideStatus(status: .start)
            //datprint("data",dataInfo[""])

        }
        
//                socket!.on("point-to-point-tracking") { (data, ack) in
//
//                    print("SSSSSOOOOOCCCKKEET_3",data)
//
//                    guard let dataInfo = data.first else { return }
//
//                    print("socketInfo",dataInfo)
//                }
        /*
        if socket?.status == .disconnected{
            SocketIOManager.sharedInstance.establishConnection()
        }
        socket!.on(clientEvent: .connect) {data, ack in
            self.isConnectedToSocket = true

        }
        socket?.on("driver-change-booking-driver-status", callback: { (data, ack) in
            print("driver-change-booking-driver-statusdfdsfdsfss",data)
        })
        
        socket?.on("accept-reject-ride", callback: { (data, ack) in
            print("accept-reject-ride_socketInfoData",data)
        })
        socket?.on("point-to-point-tracking", callback: { (data, ack) in
            print("point-to-point-tracking_socketInfoData",data)
        })
        
        */
//        socket!.on(clientEvent: .ping, callback: { data,ack in
//        print("ping")
//
//        })
//
//        socket!.on(clientEvent: .pong, callback: {data,ack in
//        print("pong")
//
//        })
        
//        socket!.on("driver-change-booking-driver-status") { (data, ack) in
//
//            print("driver-change-booking-driver-status",data)
//
//            guard let dataInfo = data.first else { return }
//
//            print("socketInfo",dataInfo)
//        }
//        
//        socket!.on("accept-reject-ride") { (data, ack) in
//            
//            print("accept-reject-ride_socketInfoData",data)
//
//            guard let dataInfo = data.first else { return }
//            
//            print("socketInfo",dataInfo)
//        }
//        
//        socket!.on("point-to-point-tracking") { (data, ack) in
//            
//            print("point-to-point-tracking_socketInfoData",data)
//
//            guard let dataInfo = data.first else { return }
//            
//            print("socketInfo",dataInfo)
//        }
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

        default:
        print("nothing")
            //checkRideStatus(status: .notFound)
        }
        
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
        
      
    }
    
    
    func checkRideStatus(status:rideStatus){
        
        
        switch status {
        case .findingTow:
            self.btnBack.isHidden = true
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
//                delay(seconds: 5) {
//                    //self.checkRideStatus(status:.requestAccept)
//                }
            }
           // self.viewLoaderInFindingTow.pulsate(animationDuration: 1.0)

        }
            print("resetMap")
            
            
        case .requestAccept:
            print("resetMap")
            self.btnBack.isHidden = true

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
                    self.lblDriverRideStatus.text = "Ride Accepted"
                    self.mapView.clear()
                    
                    let pickUp = CLLocationCoordinate2D(latitude: Double(self.objSocket?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.pick_up_longitude ?? "0.0") ?? 0.0)
                    let dropOff = CLLocationCoordinate2D(latitude: Double(self.objSocket?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.drop_off_longitude ?? "0.0") ?? 0.0)

                    self.getRouteSteps(from: pickUp, to: dropOff,markerStart: "circle",markerEnd: "car_map")
//                    delay(seconds: 10) {
//                        self.checkRideStatus(status:.reach)
//                    }
                }
                
                
            }
            
            
            //            UIView.animate(withDuration: 0.2, delay: 1, options: .curveEaseInOut) {
            //                self.bottomViewTowConstraint.constant = -400
            //                self.view.layoutIfNeeded()
            //            } completion: { _ in
            //                print("showDriverDetail")
            //            }
        case .requestReject:
            print("resetMap")
            
        case .reach:
            print("change dirction from driver to destination")
            self.btnBack.isHidden = true

            self.lblDriverRideStatus.text = "Driver Reach"
            let pickUp = CLLocationCoordinate2D(latitude: Double(self.objSocket?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.pick_up_longitude ?? "0.0") ?? 0.0)
            let dropOff = CLLocationCoordinate2D(latitude: Double(self.objSocket?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.drop_off_longitude ?? "0.0") ?? 0.0)

            self.getRouteSteps(from: pickUp, to: dropOff,markerStart: "car_map",markerEnd: "circle")
//            delay(seconds: 10) {
//                self.checkRideStatus(status:.end)
//            }
            
            
            
        case .start:
            print("start tracking")
            self.btnBack.isHidden = true

            self.lblDriverRideStatus.text = "start"

            let pickUp = CLLocationCoordinate2D(latitude: Double(self.objSocket?.pick_up_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.pick_up_longitude ?? "0.0") ?? 0.0)
            let dropOff = CLLocationCoordinate2D(latitude: Double(self.objSocket?.drop_off_latitude ?? "0.0") ?? 0.0, longitude: Double(self.objSocket?.drop_off_longitude ?? "0.0") ?? 0.0)

            self.getRouteSteps(from: pickUp, to: dropOff,markerStart: "car_map",markerEnd: "circle")
            
        case .end:
            print("move to review screen")
            self.btnBack.isHidden = true

            let vc = UtilitiesManager.shared.getMapStoryboard().instantiateViewController(withIdentifier: "AmountToPayVC") as! AmountToPayVC
            vc.booking = self.objSocket
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .notFound:
            print("resetMap")
            
            self.btnBack.isHidden = false

            mainMapVm.fetchTowList { data in
            self.objTowList = data
            self.tblTowList.reloadData()
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
                    self.bottomViewTowConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
                self.getRouteSteps(from: self.sourceLocation, to: self.destinationLocation,markerStart: "circle",markerEnd: "square")
            }
        
            //        self.addMarker(location: self.sourceLocation, markerImg: "circle")
            //        self.addMarker(location: self.destinationLocation, markerImg: "square")

            
            //            UIView.animate(withDuration: 0.2, delay: 1, options: .curveEaseInOut) {
            //                    self.bottomViewTowConstraint.constant = -400
            //                    self.view.layoutIfNeeded()
            //                }
            //            completion: { _ in
            //                self.viewLoaderInFindingTow.pulsate(animationDuration: 1.0)
            //                self.viewLoaderInFindingTow.isHidden = true
            //                self.viewTowList.isHidden = false
            //                self.btnBack.isHidden = false
            //                UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseInOut) {
            //                    self.bottomViewTowConstraint.constant = 0
            //                    self.view.layoutIfNeeded()
            //                }
            //            }
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
        
       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "") as! Re
        
        //self.navigationController?.popViewController(animated: true)
//        mainMapVm.callCancelRideApi {
//            <#code#>
//        }
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
//        mainMapVm.callCancelRideApi {
//            <#code#>
//        }
    }
    @IBAction func btnCallAction(_ sender:Any){
        
        guard let data = self.objSocket else{return}
        self.mainMapVm.dialNumber(number: data.driver_mobile_no ?? "")
        
    }
    // MARK: - NOTIFICATION_OBSERVER

    func notificationSetup(){
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(popControllerObserver), name: Notification.Name(Key.notificationKey.CALLAPIFORBOOKING), object: nil)
        nc.addObserver(self, selector: #selector(bookingCancelObserver), name: Notification.Name(Key.notificationKey.UPDATE_UI_FOR_CANCEL), object: nil)

    }
    @objc func popControllerObserver(){
        
        guard let obj = objTow else{return}
        mainMapVm.sendRequestForBooking(obj: obj) { success in
            print("sucess")
            self.checkRideStatus(status: .findingTow)
        }
    }
    @objc func bookingCancelObserver(){
        self.checkRideStatus(status: .notFound)
    }
    
    
    @objc func reasonObserver(){
        checkRideStatus(status: .requestReject)
//        guard let obj = objTow else{return}
//        mainMapVm.sendRequestForBooking(obj: obj) { success in
//            print("sucess")
//            self.checkRideStatus(status: .findingTow)
//        }
    }
    // MARK: - MAPS_SETTING
    
    
    
    func getRouteSteps(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D,markerStart:String,markerEnd:String) {
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
                    self.drawPath(from: polyLineString,markerStart: markerStart,markerEnd: markerEnd,from: source,to: destination)
                }
                
            }
        })
        task.resume()
    }
    
    //MARK:- Draw Path line
    
    func drawPath(from polyStr: String,markerStart:String,markerEnd:String,from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = .black
        polyline.map = mapView // Google MapView
        
        self.addMarker(location: source, markerImg: markerStart)
        self.addMarker(location: destination, markerImg: markerEnd)
//        self.addMarker(location: self.sourceLocation, markerImg: "circle")
//        self.addMarker(location: self.destinationLocation, markerImg: "square")

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
