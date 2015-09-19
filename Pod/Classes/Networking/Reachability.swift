//
//  Reachability.swift
//  Swift-Reachability
//
//  Created by Isuru Nanayakkara on 9/2/14.
//  Copyright (c) 2014 Isuru Nanayakkara. All rights reserved.
//

import Foundation
import SystemConfiguration


public class Reachability : Resolveable {
    
    var connected : Bool = true{
        didSet{
            print("There is Internet : \(connected)")
        }
    }
<<<<<<< HEAD
    public static var entityName :String?{
        return "reachability"
    }
=======
    public var entityName :String? = "reachability"
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    
    enum ReachabilityType {
        case WWAN,
        WiFi,
        NotConnected
    }
    
    
<<<<<<< HEAD
    public required init()
    {
       
=======
    public required init(){
        
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    }
    //Copy paste of below
    //http://stackoverflow.com/questions/25623272/how-to-use-scnetworkreachability-in-swift/25623647#25623647
    
    public func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.Reachable)
        let needsConnection = flags.contains(.ConnectionRequired)
        return (isReachable && !needsConnection)
    }
    
   
    public func isConnected() -> Bool{
        return connectedToNetwork()
    }
    
}