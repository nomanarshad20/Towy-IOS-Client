//
//  PaymentVM.swift
//  Towy
//
//  Created by Usman on 07/09/2022.
//

import Foundation

class PaymentVM : BaseVM{

    var name : String = ""
    var number : String = ""
    var month : String = ""
    var year : String = ""
    var cvc : String = ""


    
    // MARK: - DASHBOARD_HANDLING


    

    
    func callStripApi(completion:@escaping (StripeModel) -> ()){
        let h = UtilitiesManager.shared.getAuthHeader()
        let body = ["name":name,"number":number,"expiry_month":month,"expiry_year":year,"cvc":cvc] as [String:Any]

        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.createStrip, method: .post, showLoader: true).executeQuery(){
            (result: Result<StripeModel,Error>) in
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
