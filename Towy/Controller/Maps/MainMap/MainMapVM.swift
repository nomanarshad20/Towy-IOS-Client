//
//  MainMapVM.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//

import Foundation

import UIKit
import CoreLocation
class MainMapVM: BaseVM {
    var sourceLocation = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()

//    var firstName : String = ""
//    var lastName:String = ""
//    var actualNumber : String = ""

    
//    var isUserAvailable : LoginModel?{
//        didSet {
//            self.redirectControllerClosure?()
//        }
//    }
    

    
    // MARK: - DASHBOARD_HANDLING


    
    func fetchTowList(completion:@escaping (TowListModel) -> ()){
        let h = UtilitiesManager.shared.getAuthHeader()
        let body = ["pick_up_area":"Lahore","pick_up_latitude":"\(self.sourceLocation.latitude)","pick_up_longitude":"\(self.sourceLocation.longitude)","drop_off_area":"Lahore","drop_off_latitude":"\(self.destinationLocation.latitude)","drop_off_longitude":"\(self.destinationLocation.longitude)"] as [String:Any]

        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.calculateDistanceAndFare, method: .post,showLoader: true).executeQuery(){
            (result: Result<TowListModel,Error>) in
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
    
    
    func sendRequestForBooking(obj:TowDatum,completion:@escaping (BookingCreatedModel) -> ()){
        let h = UtilitiesManager.shared.getAuthHeader()
        let body = ["pick_up_area":"Lahore","pick_up_latitude":"\(self.sourceLocation.latitude)","pick_up_longitude":"\(self.sourceLocation.longitude)","drop_off_area":"Lahore","drop_off_latitude":"\(self.destinationLocation.latitude)","drop_off_longitude":"\(self.sourceLocation.longitude)","vehicle_type_id":"\(obj.vehicleTypeID)","payment_type":"cash","estimated_fare":"\(obj.estimatedFare)","total_distance":"\(obj.totalDistance)","booking_type":"book_now"] as [String:Any]

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
    
    
    
    // MARK: - Alert
    
  
    // MARK: - Validation
    
    
}
