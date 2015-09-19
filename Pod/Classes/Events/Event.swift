//
// Created by Michael Kantor on 2/13/15.
// Copyright (c) 2015 Michael Kantor. All rights reserved.
//

import Foundation

<<<<<<< HEAD
public class Event
{
=======
public class Event {
    
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    public typealias handler = (event : Event) -> ()
    
    public var name           : String?
    
    public var namespace      : String?
    
    public var lastFiredAt    : Int?
    
    public var data           : [String : AnyObject]?
    
    public var callback       : handler?
    
    public let reoccuring     : Bool
    
<<<<<<< HEAD
    public func handle()
    {
=======
    public func handle(){
        
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
        lastFiredAt = Int(NSDate().timeIntervalSince1970)
        callback!(event: self)
        
    }
    
    init(name : String,isReoccuring : Bool = true, namespace : String = "global"){
        self.name            = name
        self.reoccuring      = isReoccuring
        self.namespace       = namespace
    }
    
}