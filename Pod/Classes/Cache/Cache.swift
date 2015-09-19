//
//  Cache.swift
//  Pods
//
//  Created by Michael Kantor on 8/21/15.
//
//

import Foundation

public class Cache : Resolveable{
    
    var storage : NSCache
    
    public var entityName :String? = "cache"
    
    public required init(){
       self.storage = NSCache()
    }
    
    //returns any native value
    public func get(key: String)->AnyObject?
    {
        if let value: AnyObject = self.storage.objectForKey(key){
            return value
        }
        else
        {
            return nil
        }
    }
    
    public func set(key:String,value:AnyObject)
    {
        self.storage.setValue(value, forKey: key)
    
    }
    

}