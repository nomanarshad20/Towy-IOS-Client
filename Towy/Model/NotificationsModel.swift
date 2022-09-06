//
//  NotificationsModel.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//


import Foundation
class NotificationsModel{
    
    var newRide:NewRideModel?
    var type:Key.notificationKey.NotificationType
    var msg:String?
    init() {
        self.newRide = nil
        self.type = .NONE
        self.msg = ""
    }
    
    class func getNotificationType(dict:[AnyHashable:Any])->NotificationsModel?{
        let n = NotificationsModel()
        switch dict["notification_type"] as? String{
        case "0":
            let str = dict["msg"] as? String ?? ""
            n.msg = str
            n.type = .RIDE_REJECT
            return n
        case "1":
            print("pin point change")
            let data = dict["data"] as? String ?? ""
            let strDict = self.convertStringToDictionary(text: data)
            n.newRide = NewRideModel.getRideInfo(dict: strDict?["captain_info_data"] as? [String:Any] ?? [:])
            n.type = .RIDE_ACCEPT
            return n
        default:
            return NotificationsModel.init()
        }
    }
    
    class func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}
