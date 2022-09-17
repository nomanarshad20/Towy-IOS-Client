//
//  ReasonListModel.swift
//  Towy
//
//  Created by Usman on 12/09/2022.
//

import Foundation
// MARK: - ReasonListModel
struct ReasonListModel: Codable {
    let result, message: String
    let data: [ReasonDatum]
}

// MARK: - Datum
struct ReasonDatum: Codable {
    let id: Int
    let reason, userType: String
    var status:Bool?

    enum CodingKeys: String, CodingKey {
        case id, reason
        case userType = "user_type"
    }
}
//
//class Precaution:Codable{
//    var id:Int!
//    var text:String!
//    var status:Bool?
//    
//    init(id:Int,text:String,status:Bool) {
//        self.id = id
//        self.text = text
//        self.status = status
//    }
//    
//    class func getReasons(data:[[String:Any]])->[Precaution]{
//        var d = [Precaution]()
//        
//        for i in data{
//            d.append(Precaution.init(id: i["id"] as? Int ?? 0, text: i["reason"] as? String ?? "", status: true))
//        }
//        return d
//    }
//    
//}
