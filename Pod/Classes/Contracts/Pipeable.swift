//
//  Pipeable.swift
//  Pods
//
//  Created by Michael Kantor on 8/22/15.
//
//

import Foundation


<<<<<<< HEAD
public protocol Pipeable
=======
protocol Pipeable
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
{
    var name : String { get set}
    
    func getName()->String
    
    func setName(name:String)
    
    func isPipeReadyForMiddleware()->Bool
<<<<<<< HEAD
}
=======
}
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
