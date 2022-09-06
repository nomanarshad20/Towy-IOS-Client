//
//  SocketManager.swift
//  Towy
//
//  Created by user on 06/09/2022.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    static let sharedInstance =  SocketIOManager()
    
    var manager = SocketManager(socketURL: URL(string: "http://3.101.101.16:8081")!, config: [.log(true), .compress])
    
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
