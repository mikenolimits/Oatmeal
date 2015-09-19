//
//  Controller.swift
//  Poke
//
//  Created by Michael Kantor on 2/25/15.
//  Copyright (c) 2015 Poke Ninja. All rights reserved.
//

<<<<<<< HEAD

import Foundation
import UIKit
=======
import Foundation

>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e

public class Controller{
    
    class func getCurrentController() -> UIViewController
    {
        var current  = UIApplication.sharedApplication().keyWindow!.rootViewController!
        if let c = current.presentedViewController {
            current = c
        }
<<<<<<< HEAD
        if let q = current as? UINavigationController, first = q.viewControllers.first{
            current = first
=======
        if let q = current as? UINavigationController{
            print("IS NAV..")
            _  = q.viewControllers[0]
            current = q.viewControllers.first! 
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
        }
        return current
    }
    
    class func getNavigationController() -> UINavigationController?{
        let current =  UIApplication.sharedApplication().keyWindow!.rootViewController!
        if let q = current as? UINavigationController{
            return q
        }
<<<<<<< HEAD
=======
        print("No navigation controller found..")
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
        return nil
    }
    
    
}