//
//  Cache.swift
//  Pods
//
//  Created by Michael Kantor on 8/21/15.
//
//

import Foundation
 
public class MemoryCache : Cacheable{
    
    var storage : NSCache
    
    public static var entityName : String?{
        return "memorycache"
    }
    
    public required init()
    {
       self.storage = NSCache()
    }
    
    /**
       - parameter key: The Cache Key
       - returns: the resolved cached object
    **/
    public func get<T:Any>(key: String)->T?
    {
        if let value  = self.storage.objectForKey(key) as? T
        {
            return value
        }
        else
        {
            return nil
        }
    }

    
    /**
    - parameter key: The Cache Key
    - parameter value : The object being cached
    **/
    public func set(key:String,value:AnyObject)
    {
        //We will only cache something if it doesn't exist yet or if the cached value has already expired...
        //1. check the cache expiry time
        
        guard let _ : Any = self.get(key) else
        {
            self.storage.setValue(value, forKey: key)
            return
        }
       
    }
    
    
    /**
    - parameter key: The Cache Key
    
    - returns: Bool if a cached item with the key exists
    **/
    
    public func has(key : String)->Bool
    {
        return (self.get(key) !== nil)
    }
}