//
//  SerializeObject.swift
//  Pods
//
//  Created by Michael Kantor on 9/12/15.
//
//

import Foundation

public class SerializebleObject: NSObject
{
    //Required Init
    public required override init()
    {
        super.init()
    }
    
    //Required init for NSCoding
    public convenience required init?(coder: NSCoder) {
        self.init()
    }
    
    /*
    public class func encodeWithCoder(theObject: NSObject, aCoder: NSCoder) {
        let (hasKeys, _) = toDictionary(theObject, performKeyCleanup:false)
        for (key, value) in hasKeys {
            aCoder.encodeObject(value, forKey: key as! String)
        }
    }
    */
    
    public override func setValue(value: AnyObject!, forUndefinedKey key: String)
    {
        
        if let serializableThing = self as? canSerialize
        {
            serializableThing.setValue(value, forUndefinedKey: key)
            return
        }
        
        if let log : FileLog = ~Oats()
        {
            log.error("\nWARNING: The object '\(value.dynamicType)' is not bridgable to ObjectiveC")
        }
    
    }
    
}

/**
Protocol for the workaround when using generics. See WorkaroundSwiftGenericsTests.swift
*/
public protocol canSerialize {
    func setValue(value: AnyObject!, forUndefinedKey key: String)
}