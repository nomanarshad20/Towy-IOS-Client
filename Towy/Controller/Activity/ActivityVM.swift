//
//  ActivityVM.swift
//  Towy
//
//  Created by Usman on 27/09/2022.
//

import Foundation

class ActivityVM:BaseVM{
    
    func getTripHistory(completion:@escaping (TripHistoryModel?,Error?) -> ()){
//        let h = UtilitiesManager.shared.getAuthHeader()
        
        //let body = ["mobile_no":"actualNumber","user_type":"1"] as [String:Any]
        NetworkCall(data: [:], headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.tripHistory, method: .get,isJSONRequest: false,showAlert: false).executeQuery(){
            (result: Result<TripHistoryModel,Error>) in
            
            switch result{
            case .success(let response):
                completion(response,nil)
                print("responseForTripStatus",response)
            case .failure(let error):
                //completion(nil,error)
                print("ErrorInBookin")
                
                completion(nil,error)
            }
        }
        
    }
}
