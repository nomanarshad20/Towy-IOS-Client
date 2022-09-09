//
//  ChatModel.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//

import Foundation

import SwiftyJSON


class Message:Codable{
    
    
    
    var booking_id:String?
    var message:String?
    var messageTime:Double?
    var type:String?
    
     init(booking_id: String? = nil, receiver_id: String? = nil, sender_id: String? = nil, message: String? = nil, messageTime: Double? = nil, type: String? = nil) {
        self.booking_id = booking_id
        self.message = message
        self.messageTime = messageTime
        self.type = type
    }
    
    
    init(dict:[String:Any]) {
        self.booking_id = dict["booking_id"] as? String ?? nil
        self.message = dict["message"] as? String ?? nil
        self.messageTime = dict["messageTime"] as? Double ?? nil
        self.type = dict["type"] as? String ?? nil
    }
    
    
    class func getJsonFromMessages(messages:[Message])-> String?{
        do {
            
            
            let encoded = try JSONEncoder().encode(messages)
            let jsonString = String(data: encoded, encoding: .utf8)
            return jsonString ?? nil
//
//            let encoded = try JSONEncoder().encode(messages)
//            return (JSON(encoded).arrayObject)
        } catch {
            print(error)
        }
       return nil
    }
}
