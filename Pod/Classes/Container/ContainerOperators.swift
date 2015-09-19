//
//  ContainerOperators.swift
//  Pods
//
//  Created by Michael Kantor on 8/23/15.
//
//

import Foundation
<<<<<<< HEAD
import SwiftyJSON

prefix operator ~{}
infix operator <~>{associativity left precedence 140}

public prefix func ~<T: AnyObject>(resolver: Oatmeal) -> T?
{
    return resolver.get()
}

public prefix func ~<T: Modelable>(json : JSON) -> T?
{
    if let Serializer : Serializer = ~Container.App, model : T =  Serializer.serialize(json)
    {
        return model
    }
    return nil
}

public prefix func ~<T: Modelable>(json : String) -> T? {
    if let Serializer : Serializer = ~Container.App, model : T =  Serializer.serialize(json){
        return model
    }
    return nil
}

//infix operator ~>{ associativity left precedence 140 }
public func ~><T: Resolveable>(inout left: T, container: Oatmeal){
    container.bind(left)
}

public func ~><T: Provider>(inout provider: T, container: Oatmeal){
    container.register(provider)
}

public func ~><T: Provider>(inout providers: [T], container: Oatmeal){
    container.register(providers)
=======


prefix operator ~{}
public prefix func ~<T: AnyObject>(resolver: Oatmeal) -> T? {
    return resolver.get()
}

//infix operator ~>{ associativity left precedence 140 }
public func ~><T: Resolveable>(inout left: T, right: Oatmeal){
    Container.App.bind(left)
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
}

public func ~><T: Events>(events: T?, eventName: String)
{
    if let events : Events = ~Container.App{
        events.fire(eventName)
    }
}

<<<<<<< HEAD
public func ~><T: Modelable>(inout left: T, json: String)->T?{
    if let model : T = ~json{
        return model
    }
    return nil
}

public func ~><T: Modelable>(inout left: T, json: JSON)->T?{
    if let model : T = ~json{
        return model
    }
    return nil
}


/*
   Operator to create a strong reference to the container.
   This will bind an entity to the container without deinitializing.
   Should be used carefully.
*/
public func <~><T: Resolveable>(singleton: T, container: Oatmeal){
   container.bindSingleton(singleton)
}


public func Oats()->Oatmeal{
=======

public func App()->Oatmeal{
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    return Container.App
}
