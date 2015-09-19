//
//  Oatmeal.swift
//  Pods
//
//  Created by Michael Kantor on 8/23/15.
//
//

import Foundation
<<<<<<< HEAD
 
public protocol Oatmeal : Resolveable
{
    var singletons : [Resolveable]{
        get set 
    }
    init()
    func get<O:AnyObject>() -> O?
    func has(key:String)->Bool
    func has(key:Resolveable.Type)->Bool
    func bind(member: Resolveable)
    func bind(key:String, member:Resolveable.Type)
    func bindSingleton(singleton : Resolveable)
    func bindIf(condition : ()->Bool, withMember : Resolveable.Type, completion : ()->())
    func register(provider:ServiceProvider)
    func register(providers:[ServiceProvider])
    func open(any: Any?) -> Any.Type
=======

public protocol Oatmeal{
    func get<O:AnyObject>() -> O?
    func bind(member: Resolveable)
    func bind(key :String, member:Any)
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
}
