//
//  ReasonVM.swift
//  Towy
//
//  Created by Usman on 12/09/2022.
//

import Foundation
class ReasonVM:BaseVM{
    
    var reason = ""
    var bookingId = 0
    var reasonId = 0

    func getReasonsData(completion:@escaping (ReasonListModel) -> ()){
        // let h = UtilitiesManager.shared.getAuthHeader()
        
        //let body = ["mobile_no":"actualNumber","user_type":"1"] as [String:Any]
        NetworkCall(data: [:], headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.getCancelReason, method: .get,isJSONRequest: false,showLoader: false).executeQuery(){
            (result: Result<ReasonListModel,Error>) in
            
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
    
    func callCancelRideApi(completion:@escaping () -> ()){
        //let h = UtilitiesManager.shared.getAuthHeader()
        let body = ["other_reason":reason,"cancel_reason_id":reasonId,"booking_id":bookingId] as [String:Any]
        
        print("paramForCancel",body)
        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.cancelRide, method: .post,showLoader: true).executeQuery(){
            (result: Result<CancelRideModel,Error>) in
            switch result{
            case .success(let response):
                //completion(response)
                print("response",response)
                completion()
            case .failure(let error):
                //completion(nil,error)
                UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: error.localizedDescription)
                print("errorzz",error.localizedDescription)
            }
        }
    }
    
}
