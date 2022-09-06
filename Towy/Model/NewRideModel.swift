//
//  NewRideModel.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//

import Foundation

class NewRideModel{

    
    var booking_id:String?
    var driver_name:String?
    var driver_id:String?
    var driver_long:String?
    var contact_no:Int?
    var vehicle_number:String?
    var vehicle_model_year:String?
    var driver_ratings:String?
    var driver_lat:String?
    var profile_picture:String?
    var driver_status:String?
    var vehicle_name:String?
    var final_amount:String?
    var final_distance:String?
    var final_time:String?

    init() {
        self.booking_id = nil
        self.driver_name = nil
        self.driver_id = nil
        self.driver_long = nil
        self.contact_no = nil
        self.vehicle_number = nil
        self.vehicle_model_year = nil
        self.driver_ratings = nil
        self.driver_lat = nil
        self.profile_picture = nil
        self.driver_status = nil
        self.vehicle_name = nil
        
        self.final_amount = nil
        self.final_distance = nil
        self.final_time = nil

    }
    
     class func getRideInfo(dict:[String: Any])->NewRideModel{
       let r = NewRideModel()
        r.booking_id =  "\(dict["booking_id"] as? NSInteger ?? 0)"
        r.driver_name = dict["driver_name"] as? String ?? ""
        r.driver_id = "\(dict["driver_id"] as? NSInteger ?? 0)"
        r.driver_long = dict["driver_long"] as? String ?? ""
        r.contact_no = dict["contact_no"] as? Int ?? nil
        r.vehicle_number = dict["vehicle_number"] as? String ?? ""
        r.vehicle_model_year = dict["vehicle_model_year"] as? String ?? ""
        r.driver_ratings = "\(dict["driver_ratings"] as? NSInteger ?? 0)"
        r.driver_lat = dict["driver_lat"] as? String ?? ""
        r.profile_picture = dict["profile_picture"] as? String ?? ""
        if let driverStatus = dict["driver_status"] as? NSInteger{
            r.driver_status = "\(driverStatus)"
        }
        else{
            r.driver_status = dict["driver_status"] as? String
        }
        //r.driver_status = "\(dict["driver_status"] as? NSInteger ?? 0)"
        r.vehicle_name = dict["vehicle_name"] as? String ?? ""
        r.final_amount = "\(dict["final_amount"] ?? "")"
        r.final_distance = "\(dict["final_distance"] ?? "")"
        r.final_time = "\(dict["final_time"] ?? "")"

        return r
    }
    
}
