//
//  FileCache.swift
//  Pods
//
//  Created by Michael Kantor on 9/14/15.
//
//

import Foundation
import Carlos
import SwiftyJSON

public class FileCache : NSObject,Cacheable{
    
    public static var entityName : String? = "FileCache"
    
    
    public required override init()
    {
        super.init()
    
    }
    
    /**
       - parameter key: The Cache Key representing the file location
       - returns: the resolved cached object
    **/
    public func get(key: String,completion:(response: ResponseHandler) -> Void)
    {
        let cache   = DiskCacheLevel<String,NSString>()
        let request = cache.get(key)
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
            completion(response: handler)
        }
    }
    
    public func get<T:Modelable>(key:String)->T?
    {
        return nil
    }
    
    
    /**
      - parameter key: The Cache Key
      - parameter value : The object being cached
    **/
    
    
    public func set<T: Resolveable>(key:String,value:T)
    {
        let json = value.toJSON()
        let memoryCache = MemoryCacheLevel<String, NSString>()
        let string = json.stringValue as NSString
        memoryCache.set(string, forKey: key)
    }
    

    
}