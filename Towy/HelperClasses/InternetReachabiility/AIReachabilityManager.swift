//
//  AIReachabilityManager.swift
//  Towy
//
//  Created by Usman on 27/06/2022.
//


import UIKit
import Reachability

class AIReachabilityManager: NSObject {

    var reachability:Reachability!
    
    static let sharedManager : AIReachabilityManager = {
        let instance = AIReachabilityManager()
        return instance
    }()
    
    func isInternetAvailableForAllNetworks() -> Bool
    {
        if(self.reachability == nil){
            self.doSetupReachability()
            return self.reachability!.connection != .unavailable
        }
        else{
            return self.reachability.connection != .unavailable
        }
    }
 
    func doSetupReachability() {
        
        do{
            let reachability = try Reachability()
            
            self.reachability = reachability
        }
      /*  catch ReachabilityError.FailedToCreateWithAddress(_){
            return
        }*/
        catch ReachabilityError.failedToCreateWithAddress(_, _){
            
        }
        catch{
            
        }
        
        reachability.whenReachable = { reachability in
        }
        reachability.whenUnreachable = { reachability in
        }
        do {
            try reachability.startNotifier()
        }
        catch {
        }
    }
    deinit{
        reachability.stopNotifier()
        reachability = nil
    }
    
}
