//
//  HomeVM.swift
//  Towy
//
//  Created by Usman on 29/07/2022.
//

import Foundation
import UIKit
import CoreLocation
class HomeVM: BaseVM {
    
//    var firstName : String = ""
//    var lastName:String = ""
//    var actualNumber : String = ""

    
//    var isUserAvailable : LoginModel?{
//        didSet {
//            self.redirectControllerClosure?()
//        }
//    }
    

    
    // MARK: - DASHBOARD_HANDLING

    func setDashBoard(photoSliderView:PhotoSliderView){
        
        let images: [UIImage] = [UIImage(named: "image1")!,
                                 UIImage(named: "image2")!,
                                 UIImage(named: "image3")!,
                                 UIImage(named: "image1")!,
                                 UIImage(named: "image2")!,
                                 UIImage(named: "image3")!]
        
        photoSliderView.configure(with: images)

    }
    
//    func setDashBoardData() -> [String]{
//        return ["Towy Ride","Tire","Fuel","Battery Send","Lock","others"]
//    }

    
    func setDashBoardData() -> [AccountDataModel]{
        var arr = [AccountDataModel]()
        let obj_1 = AccountDataModel(title: "Tow", img: "car")
        let obj_2 = AccountDataModel(title: "Tire", img: "tire")
        let obj_3 = AccountDataModel(title: "Fuel", img: "fuel")
        let obj_4 = AccountDataModel(title: "Battery Send", img: "battery")
        let obj_5 = AccountDataModel(title: "Lock", img: "lock")
        let obj_6 = AccountDataModel(title: "Break Down", img: "breakdown")
        let obj_7 = AccountDataModel(title: "Engine Heat", img: "heat")
        let obj_8 = AccountDataModel(title: "others", img: "other")

        arr.append(obj_1)
        arr.append(obj_2)
        arr.append(obj_3)
        arr.append(obj_4)
        arr.append(obj_5)
        arr.append(obj_6)
        arr.append(obj_7)
        arr.append(obj_8)

        return arr
//        let images: [UIImage] = [UIImage(named: "image1")!,
//                                 UIImage(named: "image2")!,
//                                 UIImage(named: "image3")!,
//                                 UIImage(named: "image1")!,
//                                 UIImage(named: "image2")!,
//                                 UIImage(named: "image3")!]
//
//        photoSliderView.configure(with: images)

    }
    // MARK: - API_Handling
    
    
    func fetchDashBoardData(completion:@escaping (DashBoardModel) -> ()){
        //let h = UtilitiesManager.shared.getAuthHeader()
        
        //let body = ["mobile_no":"actualNumber","user_type":"1"] as [String:Any]
        NetworkCall(data: [:], headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.PassengerDashboard, method: .get,isJSONRequest: false).executeQuery(){
            (result: Result<DashBoardModel,Error>)  in
            
            switch result{
            case .success(let response):
                completion(response)
                print("response",response)
            case .failure(let error):
                //completion(nil,error)
                UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: error.localizedDescription)
                print("errorzz",error.localizedDescription)
            }
        }
        
    }
    
    func fetchNearestDrivers(location:CLLocationCoordinate2D,completion:@escaping (NearestDriverModel) -> ()){
        //let h = UtilitiesManager.shared.getAuthHeader()
        let body = ["pick_up_latitude":"\(location.latitude)","pick_up_longitude":"\(location.longitude)"] as [String:Any]

        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.findDriver, method: .post,showLoader: false,showAlert: false).executeQuery(){
            (result: Result<NearestDriverModel,Error>) in
            switch result{
            case .success(let response):
                //completion(response)
                print("response",response)
                completion(response)
            case .failure(let error):
                //completion(nil,error)
                UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: error.localizedDescription)
                print("errorzz",error.localizedDescription)
            }
        }
    }
    
    
    
    
    // MARK: - Alert
    
  
    // MARK: - Validation
    
    
}
