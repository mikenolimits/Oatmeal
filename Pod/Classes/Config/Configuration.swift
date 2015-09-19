//
//  Configuration.swift
//  Pods
//
//  Created by Michael Kantor on 8/21/15.
//
// A Place to store configuration

import Foundation

public class Configuration : Resolveable{
    
<<<<<<< HEAD
    var cache : MemoryCache?
    
    public static var entityName :String?{
        return "configuration"
    }

    public var config : [Setting] = [Setting]()
    
    required public init()
    {
        if let cache : MemoryCache = ~Oats(){
            self.cache = cache
        }
        //self.set("Settings")
    }
    
    public init(location:String)
    {
        if let cache : MemoryCache = ~Oats()
        {
            self.cache = cache
        }
        self.set(location)
    }
    
    /**
        - parameter plist: the name of the pList file in the bundle
    **/

    public func set(plist : String)
    {
        if let path = NSBundle.mainBundle().pathForResource(plist, ofType: "plist"), plist = NSDictionary(contentsOfFile: path)
        {
            //Bind the new settings to the Configuration Object
            for(key,value) in plist
            {
                let newConfig = Setting(name: key as! String,value:value,cached:true)
                config.append(newConfig)
            }
        }
    }
    
    /**
    - parameter key: The configuration Key
    - parameter value: The object being placed in the config
    - parameter cached: Boolean indicating if the configuration should be cached to avoid later I/O
    **/

    public func set(key:String, value:AnyObject, cached: Bool = false)
    {
        let newConfig = Setting(name: key,value:value,cached:cached)
        self.config.append(newConfig)
    }
    
    /**
    - parameter key: The configuration Key
    - parameter namespace: The namespace the config key might be located in
    **/
    
    public func has(key:String, namespace:String?=nil)->Bool
    {
        return (self.get(key,namespace:namespace) !== nil)
    }
    
    /**
    - parameter key: The configuration Key
    - parameter namespace: The namespace the config key might be located in
    **/
    
    public func get(key:String,namespace:String? = nil) -> AnyObject?
    {
        return self.find(key,namespace:namespace)?.value
    }

    internal func find(key:String, namespace : String? = nil)->Setting?
    {
        /*
            Is there a case use for caching settings other than to reduce IO reads of pList files?
        */
        if let cachedValue : Setting = self.cache?.get(key)
        {
            return cachedValue
        }
        else if let log : FileLog = ~Oats()
        {
            log.error("Cached missed for \(key) or MemoryCache not bound to Container")
        }
    
        if let setting = self.config.find({ $0.name == key})
        {
            return setting
        }
        else if let namespace = namespace, setting = self.config.find({$0.name == key && $0.namespace == namespace})
        {
            return setting
        }
        return nil
    }

}
=======
    var cache : Cache
    
    public var entityName :String? = "config"
    
    required public init()
    {
        self.cache  = (~App())!
    }
    
    public func get()->Any?{
        return nil
    }
    
    public func get()->AnyObject?{
        return nil
    }
}
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e