//
//  RateAndReviewVM.swift
//  Towy
//
//  Created by Usman on 12/09/2022.
//

import Foundation
class RateAndReviewVM:BaseVM {
    
    
    var rating = 1.0
    var message = ""
    var bookingId = ""
    var driverId = ""
    // MARK: - API_Handling
    
    func callRatingApi(completion:@escaping (RatingModel) -> ()){
        let h = UtilitiesManager.shared.getAuthHeader()
        
        let body = ["rating":rating,"message":message,"booking_id":bookingId,"driver_id":driverId] as [String:Any]
        
        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.saveRating, method: .post).executeQuery(){
            (result: Result<RatingModel,Error>) in
            
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
    // MARK: - Alert
    
    
    // MARK: - Validation
    
    
}
