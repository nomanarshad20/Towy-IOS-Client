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
        case waitingDriver
        case Accept
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var bottomViewTowConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var viewServiceList: UIView!
    @IBOutlet weak var viewDriverList: UIView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var viewWaiting: UIView!
    @IBOutlet weak var viewDriver: UIView!

    
    
    @IBOutlet weak var tblServicesList:UITableView!
    @IBOutlet weak var tblDriverList:UITableView!
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

    
    
    var sourceLocation  : CLLocationCoordinate2D? = nil
    private let manager = CLLocationManager()
    var servicesVM = ServicesMapVM()
    var mainMapVm = MainMapVM()

    var serviceStatus = ServicesType.selectService

    
    var serviceList :ServicesListModel? = nil
    var objServiceBooking :ServicesBookingModel? = nil

    var arrSelectedSerivces = [Services]()
    var arrSerivces = [Services]()

    var selectedDriver : DriverList? = nil
    
    var PickupArea = "USA"
    
    
    var isConnectedToSocket = false
    
    let socket = SocketIOManager.sharedInstance.socket

    var objBooking:BookingInfo? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableXib()
        setupMap()
        getService()
        self.PickupArea = servicesVM.getPickAddress(userLocation: CLLocation(latitude: self.sourceLocation?.latitude ?? 0.0, longitude: self.sourceLocation?.longitude ?? 0.0))
        self.setUIForTowFinder()
        //addSocketListerForRide()
        //addSocketListnerRideAcceptReject()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        notificationSetup()
        
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
    }
    
    
    func registerTableXib(){
        self.tblServicesList.allowsMultipleSelection = true
        //self.tblDetailList.allowsSelection = false
        self.tblServicesList.register(UINib(nibName: "ServicesListTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesListTableViewCell")
        self.tblDriverList.register(UINib(nibName: "DriverListTableViewCell", bundle: nil), forCellReuseIdentifier: "DriverListTableViewCell")
       // self.tblDetailList.register(UINib(nibName: "ServicesListTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesListTableViewCell")

    }
    
    func notificationSetup(){
        NotificationCenter.default.addObserver(self, selector: #selector(confirmRequestObserver), name: Notification.Name(Key.notificationKey.CALLAPIFORSERVICES), object: nil)
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
            
            
            self.servicesStatus(status: .waitingDriver)
        }
    }
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
    
    
    func setUIForTowFinder(){
        guard let source = self.sourceLocation else{return}
        self.getAddressFromlatLong(lat: source.latitude, long: source.longitude, lbl: self.lblSourceLocation)
    }
    
    
    
    func addMarker(location:CLLocationCoordinate2D,markerImg:String){
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
    
    
    
    func getService(){
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
            
            
        }
    }
    
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
            }
        }
    }
    
    //SETUP_SOCKET
    
    func addSocketListerForDriverLastLocation(){
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
                
                let location = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lng ?? 0.0)
                /*
                self.driverLocation = location
                self.bearing = Double(bearing) ?? 90.0
                if self.drawLineStatus == 0{
                    self.drawLineStatus = self.drawLineStatus + 1
                    self.checkDriverStatusForPolyLine(driverStatus: self.driverStatus)
                    delay(seconds: 6.0) {
                        self.addSocketListnerForLocation()
                    }
                }
                */
            }else{
                
            }
            
            
        }
    }
    
    func addSocketListerForRide(){
        socket!.on("\(UtilitiesManager.shared.getId())-driverStatus") { (data, ack) in
            print("getDriverStatus",(UtilitiesManager.shared.getId()))
            
            /*
             self.drawLineStatus = 0
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
             //                    self.lblDriverName.text = self.objSocket?.driver_first_name ?? "testing"
             
             self.getDriverLastLocation()
             }
             }else{
             if dataInfo["message"] as? String != nil{
             UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: dataInfo["message"] as? String ?? "error getting booking record")
             }
             }
             */
            
        }
    }
    func addSocketListnerForLocation(){
        socket!.on("\(UtilitiesManager.shared.getId())-driverCoordinate") { (data, ack) in
            
            print("getDriverCordinates",(UtilitiesManager.shared.getId()))
            
            guard let dataInfo = data.first as? [String:Any] else { return }
            /*
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
             if self.drawLineStatus > 0{
             self.drawLineStatus = self.drawLineStatus + 1
             self.checkDriverStatusForPolyLine(driverStatus: self.driverStatus)
             }
             
             }else{
             if dataInfo["message"] as? String != nil{
             UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: dataInfo["message"] as? String ?? "error getting booking record")
             
             }
             }
             */
            
        }
    }
    
    
    
    func addSocketListnerRideAcceptReject(){
        
        socket!.on("\(UtilitiesManager.shared.getId())-finalRideStatus") { (data, ack) in
            print("getIdFinal",(UtilitiesManager.shared.getId()))
            /*
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
             */
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
    
    
    
    
    @IBAction func btnBackAction(_ sender:Any){
        
        switch serviceStatus {
        case .selectService:
            self.navigationController?.popViewController(animated: true)
        case .selectDriver:
            self.servicesStatus(status: .selectService)
        case .detail:
            self.servicesStatus(status: .selectDriver)
        case .waitingDriver:
            self.navigationController?.popViewController(animated: true)
        case .Accept:
            self.navigationController?.popViewController(animated: true)
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
//        let pickUpArea = servicesVM.getPickAddress(userLocation: CLLocation(latitude: self.sourceLocation?.latitude ?? 0.0, longitude: self.sourceLocation?.longitude ?? 0.0))
        
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
        self.lblTime.text = "\(obj.distance ?? 0.0)KM"
        guard let services = obj.service else{return}
        self.lblService.text = getServices(arr: services)

        
        /*
        var services = [Service]()
        
        
        guard let selectedDriver = selectedDriver else {
            return
        }
        guard let objBooking = objBooking else {
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
            //print("okay")
        }
        */
        servicesStatus(status: .detail)
        
        
    }
    @IBAction func btnConfirmBookingAction(_ sender:Any){
        print("confirm booking")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingConfirmationVC") as! BookingConfirmationVC
        vc.type = .services
        self.present(vc, animated: false)

    }
    @IBAction func btnCancelRideAction(_ sender:Any){
    }
    @IBAction func btnChatAction(_ sender:Any){
        let vc = UtilitiesManager.shared.getMainStoryboard().instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        //vc.booking = self.objSocket
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnCancelServiceAction(_ sender:Any){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReasonVC") as! ReasonVC
        //vc.booking = self.objSocket
        self.present(vc, animated: false)
    }
    @IBAction func btnCallAction(_ sender:Any){
        
        //guard let data = self.objSocket else{return}
        //self.mainMapVm.dialNumber(number: data.driver_mobile_no ?? "")
        
    }
}



extension ServicesMapVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblServicesList{
            return self.arrSerivces.count ?? 0
        }else if tableView == self.tblDriverList{
            guard let data = self.objServiceBooking?.data?.driverList else{return 0}
            return data.count
        }else{
            return arrSelectedSerivces.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesListTableViewCell", for: indexPath) as! ServicesListTableViewCell
           // guard let obj = self.serviceList?.data else{return cell}
            cell.obj = arrSelectedSerivces[indexPath.row]
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
}
