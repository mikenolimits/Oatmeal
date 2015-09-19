//
//  Cacheable.swift
//  Pods
//
//  Created by Michael Kantor on 9/14/15.
//
//

import Foundation

public protocol Cacheable : Resolveable{
    
    func has(key:String)->Bool
    func get<T:Any>(key: String)->T?
    func set(key:String,value:AnyObject)
}