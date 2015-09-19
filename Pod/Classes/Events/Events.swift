//
// Created by Michael Kantor on 2/13/15.
// Copyright (c) 2015 Michael Kantor, Oatmeal. All rights reserved.
//

import Foundation

//Closure Based Events Bound to the container of the IoC.

<<<<<<< HEAD
 public class Events : Eventable {
=======
 public class Events : Resolveable {
    
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    
    private lazy var globalListeners = [String : Event]()
    
    private lazy var localListeners  = [String : Event]()
    
<<<<<<< HEAD
    public static var entityName : String?{
        return "events"
    }
    
    public func all() -> [String : Event]
=======
    public var entityName  : String?
    
    func all() -> [String : Event]
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    {
        return self.globalListeners
    }

    public required init()
    {
<<<<<<< HEAD
        
    }
    
    public subscript(key : String) -> Event?{
        get{
            return get(key)
        }
    }
    
    public func get(key:String) -> Event?
    {
        if let e = globalListeners[key]
        {
            return e
        }
        if let e = localListeners[key]
        {
            let className = getNamespace()
            
            if let name = className where e.namespace == String(name)
            {
                return e
            }
        }
        return nil
    }
    
    public func has(key:String)->Bool
    {
        return get(key) != nil
    }
    
    /**
       - parameter event : The name of the event so it can later be fired.
       - parameter namespace: the namespace where the event should only be resolved.
       - parameter handler : the closure or method that should be executed when the event is fired
      
        Bind a new event to a specific namespace, or replace a specific one
    **/
=======
        self.entityName = "events"
        
    }
    
    /*
      Bind a new event to a specific namespace
    */
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    public func listenFor(event:String,namespace:String,handler : (event : Event) -> Void)
    {
        let e  = Event(name : event)
        
         e.callback = { (event : Event) -> () in
            e.lastFiredAt = Int(NSDate().timeIntervalSince1970)
            handler(event: e)
        }
        
        e.namespace = namespace
        localListeners[event] = e
        
    }
<<<<<<< HEAD
    /**
    - parameter event : The name of the event so it can later be fired.
    - parameter global: Defines if the event should be accessible from any part of the application
    - parameter handler : the closure or method that should be executed when the event is fired
    
        Generic method for binding a method to the IoC
    **/
=======
    
    /*
    Bind a new event to the IoC
    */
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    public func listenFor(event : String, global : Bool = true, handler : (event : Event) -> Void){
        
        let e  = Event(name : event)
        
        e.callback = { (event : Event) -> () in
            e.lastFiredAt = Int(NSDate().timeIntervalSince1970)
            handler(event: e)
        }
        
        //If the directive is not global, then we make the assumption that the event
        //is only to be resolved if the controller is the same as the one the event
        //was created in
        
        if(global)
        {
<<<<<<< HEAD
            globalListeners[event] = e
        }
        //Reflect the currently used controller and gets it objectId
        else if let className = getNamespace()
        {
            e.namespace = "\(className)"
            localListeners[event] = e
        }
    }
    
    /**
         - parameter event : The name of the event that should be removed from the IoC
    **/
=======
            
            globalListeners[event] = e
            
        }
        else
        {
            //Reflect the currently used controller and gets it objectId
            if let className = getNamespace() {
                //print("The Class Name is \(className)", appendNewline: false)
                e.namespace = "\(className)"
                localListeners[event] = e
            }
        }
    }
    
    
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    public func dispose(event : String){
        globalListeners.removeValueForKey(event)
        localListeners.removeValueForKey(event)
    }
    
<<<<<<< HEAD
    /**
       Iterates through all controller namespaces and removes their events
    **/
    public func flush()
    {
        //Loop through the current controllers events & "flush" them
        if let className = getNamespace()
        {
            for (key,value) in localListeners
            {
                if let namespace = value.namespace where className == namespace
                {
=======
    
    public func flush()
    {
        //Loop through the current controllers events & "flush" them
        if let className = getNamespace(){
            for (key,value) in localListeners{
                if className == value.namespace!{
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
                    localListeners.removeValueForKey(key)
                }
            }
        }
        
    }
    
    
<<<<<<< HEAD
    func getNamespace()->String?
    {
        let current              = Controller.getCurrentController()
        let className            = Mirror(reflecting: current).subjectType
        
        return String(className)
    }
    
    
    public func fire(event : String,
        payload : [String : AnyObject]? = nil) -> (Bool,Event?)
    {
        
        if let e = get(event)
        {
            if let data = payload
            {
               e.data = data
            }
            
            e.callback?(event: e)
            
            return (true,e)
        }
        
        print("Event \(event) Does Not Exist.", terminator: "")
        
        return (false,nil)
=======
    func getNamespace()->String?{
        
        let current              = Controller.getCurrentController()
        
        let className            = Mirror(reflecting: current).subjectType
        
        
        return String(className)
    }
    
    public func fire(event : String,
        object : [String : AnyObject]? = nil) -> (Bool,Event?){
            
            
            if let e = globalListeners[event]{
                
                if let data = object{
                    
                    e.data = data
                }
                
                e.callback!(event: e)
            }
            else if let e = localListeners[event]{
                
                let className = getNamespace()
                
                if let name = className where e.namespace == String(name){
                    
                        if let data = object
                        {
                            
                            e.data = data
                        }
                        
                        e.callback!(event : e)
                        return (true,e)
                }
                else
                {
                    return (false,e)
                }
                
            }
            else{
                print("Event Does Not Exist.", appendNewline: false)
            }
            
            return (false,nil)
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    }
    
}