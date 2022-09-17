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

        case accept
        case driverStatus
        case pointToPoint
        
//        case listen

        var emitterName: String {
            switch self {
            case .accept:
                return "emt_search_tags"
            case .driverStatus:
                return "emt_search_tags"
            case .pointToPoint:
                return "emt_search_tags"
            }
        }

        var listnerName: String {
            switch self {
            case .accept:
                return "accept-reject-ride"
            case .driverStatus:
                return "driver-change-booking-driver-status"
            case .pointToPoint:
                return "point-to-point-tracking"
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
