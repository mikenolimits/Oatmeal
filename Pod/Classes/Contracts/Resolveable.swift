//
//  Resolveable.swift
//  Pods
//
//  Created by Michael Kantor on 8/22/15.
//
//


public protocol Resolveable
{
    /**
        - var entityName : the alternative name for the resolved object
    **/
    
    static var entityName: String? { get }
    init()
    func dependsOn() -> [Resolveable.Type]
    func toProps(model:Resolveable) -> [String:Property]
    func getName() -> String?
}