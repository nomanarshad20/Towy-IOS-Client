//
//  MainMapVM.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//

import Foundation
import UIKit
import CoreLocation

// A delay function
func delay(seconds: Double, completion: @escaping ()-> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}
class MainMapVM: BaseVM {
    var sourceLocation = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    var address = "Lahore"
    
    //31.503927020483896, 74.28089801055975
    var localDriverLatLong = CLLocationCoordinate2D(latitude: 31.503927020483896, longitude: 74.28089801055975)
    //var 
    //    var firstName : String = ""
    //    var lastName:String = ""
    //    var actualNumber : String = ""
    
    
    //    var isUserAvailable : LoginModel?{
    //        didSet {
    //            self.redirectControllerClosure?()
    //        }
    //    }
    
    
    
    // MARK: - DASHBOARD_HANDLING
    
    
    
    func fetchTowList(completion:@escaping (TowListModel?,Error?) -> ()){
        let h = UtilitiesManager.shared.getAuthHeader()
        let body = ["pick_up_area":"Lahore","pick_up_latitude":"\(self.sourceLocation.latitude)","pick_up_longitude":"\(self.sourceLocation.longitude)","drop_off_area":"Lahore","drop_off_latitude":"\(self.destinationLocation.latitude)","drop_off_longitude":"\(self.destinationLocation.longitude)"] as [String:Any]
        
        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.calculateDistanceAndFare, method: .post,showLoader: true).executeQuery(){
            (result: Result<TowListModel,Error>) in
            switch result{
            case .success(let response):
                //completion(response)
                print("response",response)
                completion(response,nil)
            case .failure(let error):
                completion(nil,error)
                UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: error.localizedDescription)
                print("errorzz",error.localizedDescription)
                
            }
        }
    }
    
    
    func sendRequestForBooking(obj:TowDatum,completion:@escaping (BookingCreatedModel) -> ()){
        // let h = UtilitiesManager.shared.getAuthHeader()
        let body = ["pick_up_area":"Lahore","pick_up_latitude":"\(self.sourceLocation.latitude)","pick_up_longitude":"\(self.sourceLocation.longitude)","drop_off_area":address,"drop_off_latitude":"\(self.destinationLocation.latitude)","drop_off_longitude":"\(self.destinationLocation.longitude)","vehicle_type_id":"\(obj.vehicle_type_id ?? 0)","payment_type":"cash","estimated_fare":"\(obj.estimated_fare ?? 0)","total_distance":"\(obj.total_distance ?? 0)","booking_type":"book_now"] as [String:Any]
        
        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.createBookingWithAllParam, method: .post,showLoader: true).executeQuery(){
            (result: Result<BookingCreatedModel,Error>) in
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
    
    func getAddress(userLocation:CLLocation){
        let geocoder = CLGeocoder()
          geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
              if (error != nil){
                  print("error in reverseGeocode")
              }
              let placemark = placemarks! as [CLPlacemark]
              if placemark.count>0{
                  let placemark = placemarks![0]
                  print(placemark.locality!)
                  print(placemark.administrativeArea!)
                  print(placemark.country!)
                  self.address = placemark.locality ?? ""
              }
          }

      }
    
    
    func getBookingStatus(completion:@escaping (BookingStatusCheckModel?,Error?) -> ()){
        let h = UtilitiesManager.shared.getAuthHeader()
        
        //let body = ["mobile_no":"actualNumber","user_type":"1"] as [String:Any]
        NetworkCall(data: [:], headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.passengerStatus, method: .get,isJSONRequest: false,showAlert: false).executeQuery(){
            (result: Result<BookingStatusCheckModel,Error>) in
            
            switch result{
            case .success(let response):
                completion(response,nil)
                print("responseForBookingStatus",response)
            case .failure(let error):
                //completion(nil,error)
                print("ErrorInBookin")
                
                completion(nil,error)
            }
        }
        
    }
    
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }
    
    // MARK: - Alert
    
    
    // MARK: - Validation
    
    
}
