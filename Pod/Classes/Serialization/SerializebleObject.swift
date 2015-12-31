//
//  SerializeObject.swift
//  Pods
//
//  Created by Michael Kantor on 9/12/15.
//
//

import Foundation

public class SerializebleObject: NSObject, NSCoding,Resolveable
{
    //Required Init
    public static var entityName : String?
    
    public required override init()
    {
    
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init()
        let properties = toProps()
        for i in properties
        {
            let jValue = i.1.value
            let key    = i.0
            var value : AnyObject? = nil
            switch jValue
            {
            case _ as Int:
                value  = aDecoder.decodeIntegerForKey(key)
            case _ as  Double:
                value  = aDecoder.decodeDoubleForKey(key)
            case _ as AnyObject:
                value  = aDecoder.decodeObjectForKey(key)
            default:
                print("something else")
            }
            setValue(value, forUndefinedKey: key)
        }
        
    }
    
    public func encodeWithCoder(aCoder: NSCoder)
    {
        let properties = toProps()
        for i in properties
        {
            let jValue = i.1.value
            let key    = i.0
            switch jValue
            {
                case let v as Int:
                    aCoder.encodeInteger(v, forKey: key)
                case let v as Double:
                    aCoder.encodeDouble(v, forKey: key)
                case let v as String:
                    aCoder.encodeObject(v, forKey: key)
                case let v as AnyObject:
                    aCoder.encodeObject(v, forKey: key)
                default:
                        print("something else")
            }
        }
    }
    
    
    public override func setValue(value: AnyObject!, forUndefinedKey key: String)
    {
        
        if let serializableThing = self as? Autoresolves
        {
            serializableThing.setValue(value, forKey: key)
            return
        }
        
        if let log : FileLog = ~Oats()
        {
            log.error("\nWARNING: The object '\(value.dynamicType)' is not bridgable to ObjectiveC")
        }
    
    }
    
}
