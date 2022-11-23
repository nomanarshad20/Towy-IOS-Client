//
//  ServicesMapVM.swift
//  Towy
//
//  Created by Usman on 14/11/2022.
//

import Foundation
class ServicesMapVM: BaseVM {
    
  
    
    
    func getServiceList(completion:@escaping (ServicesListModel?,Error?) -> ()){
        let h = UtilitiesManager.shared.getAuthHeader()
        print("Header",h)
        NetworkCall(data: [:], headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.servicesList, method: .get,isJSONRequest: false,showAlert: false).executeQuery(){
            (result: Result<ServicesListModel,Error>) in
            
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
    
    
    func createServiceBooking(body:[String:Any],completion:@escaping (BookingCreatedModel) -> ()){
        /*
        let body = ["pick_up_area":"Lahore","pick_up_latitude":"\(self.sourceLocation.latitude)","pick_up_longitude":"\(self.sourceLocation.longitude)","drop_off_area":address,"drop_off_latitude":"\(self.destinationLocation.latitude)","drop_off_longitude":"\(self.destinationLocation.longitude)","vehicle_type_id":"\(obj.vehicle_type_id ?? 0)","payment_type":"cash","estimated_fare":"\(obj.estimated_fare ?? 0)","total_distance":"\(obj.total_distance ?? 0)","booking_type":"book_now"] as [String:Any]
        */
        let h = UtilitiesManager.shared.getAuthHeader()
        print("Header",h)

        
        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.createServiceBooking, method: .post,showLoader: true).executeQuery(){
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
    
}
