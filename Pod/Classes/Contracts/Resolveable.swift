//
//  Resolveable.swift
//  Pods
//
//  Created by Michael Kantor on 8/22/15.
//
//

<<<<<<< HEAD
//import Foundation

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
=======
import Foundation

public protocol Resolveable{
    var entityName : String? {get set}
    init()
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
}