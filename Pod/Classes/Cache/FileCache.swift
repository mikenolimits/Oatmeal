//
//  FileCache.swift
//  Pods
//
//  Created by Michael Kantor on 9/14/15.
//
//

import Foundation

public class FileCache : Cacheable{
    
    public static var entityName : String?{
        return "filecache"
    }
    
    
    public required init()
    {
    
    }
    
    /**
       - parameter key: The Cache Key representing the file location
       - returns: the resolved cached object
    **/
    public func get<T:Any>(key: String)->T?
    {
        return nil
    }
    
    public func get<T:Modelable>(key:String)->T?
    {
        return nil
    }
    
    
    /**
      - parameter key: The Cache Key
      - parameter value : The object being cached
    **/
    
    
    public func set(key:String,value:AnyObject)
    {
       
        
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