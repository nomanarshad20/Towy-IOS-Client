//
//  Precaution.swift
//  Towy
//
//  Created by Usman on 12/09/2022.
//

import Foundation
class Precaution:Codable{
    var id:Int!
    var text:String!
    var status:Bool?
    
    init(id:Int,text:String,status:Bool) {
        self.id = id
        self.text = text
        self.status = status
    }
    
    class func getReasons(data:[[String:Any]])->[Precaution]{
        var d = [Precaution]()
        
        for i in data{
            d.append(Precaution.init(id: i["id"] as? Int ?? 0, text: i["reason"] as? String ?? "", status: true))
        }
        return d
    }
    
}
