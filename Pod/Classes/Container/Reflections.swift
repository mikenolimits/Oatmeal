//
//  Reflections.swift
//  Pods
//
//  Created by Michael Kantor on 12/17/15.
//
//

import Foundation

//Used to store already reflected classes

public class Reflections : Resolveable
{
    public static var entityName : String? = "Reflections"
    typealias reflected = [String: properties]
    
    private var mirrors : reflected
    
    public subscript(key : String) -> properties?{
        get{
            return get(key)
        }
        set(newProp)
        {
            if let value = newProp
            {
               set(key,value : value)
            }
        }
    }
    
    
    public required init()
    {
        mirrors  = reflected()
    }
    
    public func get(key:String) -> properties?
    {
        if let mirror = mirrors[key]
        {
            return mirror
        }
        return nil
    }
    
    public func set(key:String, value : properties)
    {
        mirrors[key] = value
    }
    
    public func has(key:String)->Bool
    {
        return get(key) != nil
    }
}