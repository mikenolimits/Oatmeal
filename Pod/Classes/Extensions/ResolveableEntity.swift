//
//  Resolveable.swift
//  Pods
//
//  Created by Michael Kantor on 9/14/15.
//
//

import Foundation

public extension Resolveable
{
 
    public func toProps(model:Resolveable) -> [String:Property]
    {
        //A Model has a default init, and this is a requirement if we want to parse the properties
        
        let model                = model
        let reflectedModel       = Mirror(reflecting: model)
        var reflectedProperties  = [String:Property]()
        
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
    
    public func dependsOn() -> [Resolveable.Type]
    {
        var entities = [Resolveable.Type]()

        let mirror = self.toProps(self)
            
        let resolveableTypes : [String:Property] = mirror.filter({
            print("Model has \($0.1.type)")
            return "\($0.1.type)" == "\(Resolveable.self)"
        })
            
        for(_,prop) in resolveableTypes
        {
            if let resolveable =  prop.type as? Resolveable.Type
            {
                entities.append(resolveable)
            }
        }
        return entities
    }
    
    public func getName() -> String?
    {
        let type = self.dynamicType
        return type.entityName
    }
    
}