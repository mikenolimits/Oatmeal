//
//  Resolveable.swift
//  Pods
//
//  Created by Michael Kantor on 9/14/15.
//
//

import Foundation
import SwiftyJSON

public struct DidResolve
{
    var success : Bool
    var key : String
}

public typealias properties = [String:Property]

public extension Resolveable
{
    
    public var cost: Int
    {
       var c = 0
       let props = toProps()
       for(_,value) in props
       {
        switch(value.value)
        {
         case _ as Int:
            c++
         case _ as Double:
            c++
         case _ as Float:
            c++
         case _ as Int64:
            c += 8
         case _ as Int32:
            c += 4
         case let asString as String:
            c += asString.length
         case let nsString as NSString:
            c += nsString.length
         case  _ as String:
            c++
         default:
             break
        }
       }
        return c
    }
    
    public func toJSON() -> JSON
    {
        let props   = toProps()
        
        var jObject = JSON([String:JSON]())
        
        for(key,value) in props
        {
            jObject[key] = JSON("\(value.value)")
        }
        
        return jObject
    }
 
    public func toProps() -> properties
    {
        //If the properties were already parsed, we're just going to fetch them.
        if let reflector : Reflections = ~Oats(),props = reflector.get(getName())
        {
            return props
        }
        //A Model has a default init, and this is a requirement if we want to parse the properties
        let reflectedModel       = Mirror(reflecting: self)
        var reflectedProperties  = properties()
        
        //First we're going to reflect the type and grab the types of properties
        
        if let  children = AnyRandomAccessCollection(reflectedModel.children)
        {
            
            for (optionalPropertyName, value) in children
            {
                if let name  = optionalPropertyName
                {
                    let propMirror = Mirror(reflecting: value)
                    let type       = Oats().open(value)
                    let property   = Property(mirror: propMirror, label : name,value : value, type : type)
                    reflectedProperties[name] = property
                }
            }
        }
        return reflectedProperties
    }

    
    public func resolvableFilter(prop: Property) -> DidResolve
    {
        var name  = String(prop.mirror.subjectType)
        
        if(prop.mirror.displayStyle != .Optional)
        {
             let test = prop.value is Resolveable
             return DidResolve(success: test, key: name)
        }
        if let match = name["<(.*?)>"]
        {
            name      = match
            
            name      = name.stringByReplacingOccurrencesOfString(">",withString: "")
            
            name      = name.stringByReplacingOccurrencesOfString("<",withString: "")
            
            if Oats().has(name)
            {
                return DidResolve(success: true, key: name)
            }
        }
        return DidResolve(success: false, key: name)
       
    }

    
    public func dependencies(var props : properties = properties()) -> properties
    {
        var entities = properties()
        
        if let reflector  : Reflections = ~Oats()
        {
        
        let name   = getName()
        
        if props.count <= 0
        {
            props = self.toProps()
            reflector[name] = props
        }
        
        for(_,prop) in props
        {
        
            let value : DidResolve = self.resolvableFilter(prop)
            
            if(value.success)
            {
                entities[value.key] = prop
            }
        }
        }
        return entities
    }
    
    public func getName() -> String
    {
        let dynamicName = self.dynamicType
        var name = ""
        if let entityName = dynamicName.entityName{
            name = entityName
        }
        else
        {
            name = String(dynamicName).capitalizedString.stringByReplacingOccurrencesOfString(".Type",withString: "")
        }
        return name
    }
    
}