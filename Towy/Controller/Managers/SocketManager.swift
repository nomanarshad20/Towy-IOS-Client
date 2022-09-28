//
//  SocketManager.swift
//  Towy
//
//  Created by user on 06/09/2022.
//

import Foundation
import SocketIO
/*
class SocketIOManager: NSObject {
    
    static let sharedInstance =  SocketIOManager()
    //http://54.183.143.65:8081/
//"http://3.101.101.16:8081"
    var manager = SocketManager(socketURL: URL(string: "http://54.183.143.65:8081")!, config: [.log(true), .compress])
    
    var socket : SocketIOClient!
    
    override init() {
        super.init()
        establishConnection()
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected \(data)")
        }
    }
    
    func establishConnection() {
        self.socket = manager.defaultSocket
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
*/
class SocketHelper {
    
    static let shared = SocketHelper()
    var socket: SocketIOClient!
    
    let manager = SocketManager(socketURL: URL(string: APPURL.SocketUrl)!, config: [.log(true), .compress])
    
    private init() {
        socket = manager.defaultSocket
    }
    
    func connectSocket(completion: @escaping(Bool) -> () ) {
        disconnectSocket()
        socket.on(clientEvent: .connect) {[weak self] (data, ack) in
            print("socket connected")
            self?.socket.removeAllHandlers()
            completion(true)
        }
        socket.connect()
    }
    
    func disconnectSocket() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }
    
    func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false
        
    }
    
    enum Events {
        
        case driverCoordinate
        case driverStatus
        case finalRide
        
        //        case listen
        
        var emitterName: String {
            switch self {
            case .driverCoordinate:
                return "emt_search_tags"
            case .driverStatus:
                return "emt_search_tags"
            case .finalRide:
                return "emt_search_tags"
            }
        }
        
        var listnerName: String {
            switch self {
            case .driverCoordinate:
                return "\(UtilitiesManager.shared.getId())-driverCoordinate"
            case .driverStatus:
                return "\(UtilitiesManager.shared.getId())-driverStatus"
            case .finalRide:
                return "\(UtilitiesManager.shared.getId())-finalRideStatus"
            }
        }
        
        func emit(params: [String : Any]) {
            SocketHelper.shared.socket.emit(emitterName, params)
        }
        
        func listen(completion: @escaping ([Any]) -> Void) {
            
            SocketHelper.shared.socket.on(listnerName) { (response, emitter) in
                completion(response)
            }
        }
        
        func off() {
            SocketHelper.shared.socket.off(listnerName)
        }
    }
}


class SocketIOManager: NSObject {
    
    
    
    
    static let sharedInstance =  SocketIOManager()
    
    var manager = SocketManager(socketURL: URL(string: APPURL.SocketUrl)!, config: [.log(true), .compress])
    
    var socket : SocketIOClient!
    
    override init() {
        super.init()
        
        establishConnection()
        
        
//        socket.joinNamespace("point-to-point-tracking") // Create a socket for the /swift namespac
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected \(data)")
            
//            let id:String = getDataFromPreference(key: ID)
//            let identifier:String = getDataFromPreference(key: IDENTIFIER)
//            self.socket.emit(
//                "point-to-point-tracking", ["latitude":"31.66666666","longitude":"74.65656565","area_name":"area_name","city":"city","bearing":90,"booking_id":0,"user_id":27]
//            )
            
        }
        
//        socket.on("point-to-point-tracking") { dataArray, ack in
//            print("socket connected \(dataArray)")
//        }
        
    }
    
    func establishConnection() {
        self.socket = manager.defaultSocket
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
