//
//  Cache.swift
//  Pods
//
//  Created by Michael Kantor on 8/21/15.
//
//

import Foundation
import Carlos
import SwiftyJSON

public class MemoryCache : NSObject,Cacheable{
    
    var log : FileLog?
    
    public static var entityName : String? = "MemoryCache"
    
    public required override init()
    {
        super.init()
    }
    
    /**
       - parameter key: The Cache Key
       - returns: the resolved cached object
    **/
    public func get(key: String,completion:(response: ResponseHandler) -> Void)
    {
    
        let memoryCache = MemoryCacheLevel<String, NSString>()
        let request = memoryCache.get(key)
        var handler = ResponseHandler()
        
        request.onSuccess { value in
            handler.response = JSON(value)
            handler.responseString = value as String
            handler.success = true
            completion(response: handler)
        }
        request.onFailure { error in
            handler.success = false
            handler.error   = error
            if let logger = self.log {
                logger.error("Cache missed for \(key)")
            }
            completion(response: handler)
        }
    }

    
    /**
    - parameter key: The Cache Key
    - parameter value : The object being cached
    **/
    public func set<T: Resolveable>(key:String,value:T)
    {
        //We will only cache something if it doesn't exist yet or if the cached value has already expired...
        //1. check the cache expiry time
        
        let json = value.toJSON()
        let memoryCache = MemoryCacheLevel<String, NSString>()
        let string = json.stringValue as NSString
        memoryCache.set(string, forKey: key)
    }
    

}