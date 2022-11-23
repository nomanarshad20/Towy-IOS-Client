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
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var bottomViewTowConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var viewServiceList: UIView!
    @IBOutlet weak var viewDriverList: UIView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var tblServicesList:UITableView!
    @IBOutlet weak var tblDriverList:UITableView!
    @IBOutlet weak var tblDetailList:UITableView!

    
    var sourceLocation  : CLLocationCoordinate2D? = nil
    private let manager = CLLocationManager()
    var servicesVM = ServicesMapVM()
    var service = ServicesType.selectService

    
    var serviceList :ServicesListModel? = nil

    var arrSelectedSerivces = [Services]()
    var arrSerivces = [Services]()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableXib()
        setupMap()
        getService()
    }
    
    
    
    
    func registerTableXib(){
        self.tblServicesList.allowsMultipleSelection = true
        self.tblDetailList.allowsSelection = false
        self.tblServicesList.register(UINib(nibName: "ServicesListTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesListTableViewCell")
        self.tblDriverList.register(UINib(nibName: "DriverListTableViewCell", bundle: nil), forCellReuseIdentifier: "DriverListTableViewCell")
        self.tblDetailList.register(UINib(nibName: "ServicesListTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesListTableViewCell")

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
    
    
    
    
    func addMarker(location:CLLocationCoordinate2D,markerImg:String){
        let myMarker = GMSMarker()
        myMarker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        myMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        myMarker.map = self.mapView
        myMarker.icon = UIImage(named: markerImg)
        myMarker.setIconSize(scaledToSize: .init(width: 30, height: 30))
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
        switch status {
        case .selectService:
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.bottomViewTowConstraint.constant = -400
                self.view.layoutIfNeeded()
            }completion: { _ in
                
                self.viewDriverList.isHidden = true
                self.viewDetail.isHidden = true
                self.viewServiceList.isHidden = false
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
                
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn) {
                    self.bottomViewTowConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnNextToDriverAction(_ sender:Any){
        servicesStatus(status: .selectDriver)
    }
    @IBAction func btnNextToDetailAction(_ sender:Any){
        servicesStatus(status: .detail)
    }
    @IBAction func btnConfirmBookingAction(_ sender:Any){
        print("confirm booking")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingConfirmationVC") as! BookingConfirmationVC
        vc.type = .services
        self.present(vc, animated: false)

    }
}



extension ServicesMapVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblServicesList{
            return self.arrSerivces.count ?? 0
        }else if tableView == self.tblDriverList{
            return 5
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
            //guard let obj = self.serviceList?.data else{return}
            let data = self.arrSerivces[indexPath.row]
            self.arrSelectedSerivces.append(data)
            self.tblDetailList.reloadData()
        }else if tableView == self.tblDriverList{
            print("tblDriverList")
        }else{
            print("detail")
        }
       // guard let obj = self.serviceList?.data else{return}
//        self.objTow = obj[indexPath.row]
//        self.btnConfirm.setTitle("Confirm \(obj[indexPath.row].name ?? "")", for: .normal)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Desleelelle")
       // guard let obj = self.serviceList?.data else{return}
        let data = self.arrSerivces[indexPath.row]

        let ind = self.arrSelectedSerivces.firstIndex(where: {$0.id == data.id})
        guard let indexx = ind else{return}
        self.arrSelectedSerivces.remove(at: indexx)
//        self.arrSelectedSerivces.remove(at: indexPath.row)
        //self.tblDetailList.reloadData()
        self.tblDetailList.reloadData()

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

        if objData.quantity > 0{
            self.arrSerivces[sender.tag].quantity = objData.quantity - 1
        }
    
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
}
