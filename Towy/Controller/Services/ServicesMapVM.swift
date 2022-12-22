//
//  ServicesMapVM.swift
//  Towy
//
//  Created by Usman on 14/11/2022.
//

import Foundation
import SwiftyJSON
import CoreLocation
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
    
    
    func createServiceBooking(model:ServiceBookingModel,completion:@escaping (ServicesBookingModel) -> ()){
        
        /*
         {
         "services": [
         {
         "id": 1,
         "quantity": 2
         },
         {
         "id": 2,
         "quantity": 0
         }
         ],
         "pick_up_area": "Plot 134 A, Ahmed Block Garden Town, Lahore, Punjab, Pakistan",
         "pick_up_lat": 31.5079908,
         "pick_up_lng": 74.319544
         }
         */
        
        let dictionary = try! DictionaryEncoder().encode(model)
        guard let dict = JSON(dictionary).dictionaryObject else{return}
        print("dict",dict)

        let h = UtilitiesManager.shared.getAuthHeader()
        print("Header",h)

        
        NetworkCall(data: dict, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.createServiceBooking, method: .post,showLoader: true).executeQuery(){
            (result: Result<ServicesBookingModel,Error>) in
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
    
    
    func sendServicesRequest(model:ServiceBookingRequestModel,completion:@escaping (ServiceBookingCreatedModel) -> ()){
        
    
        
        let dictionary = try! DictionaryEncoder().encode(model)
        guard let dict = JSON(dictionary).dictionaryObject else{return}
        print("dict",dict)

        let h = UtilitiesManager.shared.getAuthHeader()
        print("Header",h)

        
        NetworkCall(data: dict, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.sendServiceRideRequest, method: .post,showLoader: true).executeQuery(){
            (result: Result<ServiceBookingCreatedModel,Error>) in
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
    
    
    
    func getPickAddress(userLocation:CLLocation) -> String{
        let geocoder = CLGeocoder()
        
        var location = "USA"
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                if let locality = placemark.locality{
                    location = locality
                    return
                }
                if let administrativeArea = placemark.administrativeArea{
                    location = administrativeArea
                    return
                }
                if let country = placemark.country{
                    location = country
                    return
                }
            }
            
        }
        return location
    }
    
}
