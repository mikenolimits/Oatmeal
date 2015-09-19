//
//  Controller.swift
//  Poke
//
//  Created by Michael Kantor on 2/25/15.
//  Copyright (c) 2015 Poke Ninja. All rights reserved.
//


import Foundation
import UIKit

public class Controller{
    
    class func getCurrentController() -> UIViewController
    {
        var current  = UIApplication.sharedApplication().keyWindow!.rootViewController!
        if let c = current.presentedViewController {
            current = c
        }
        if let q = current as? UINavigationController, first = q.viewControllers.first{
            current = first
            print("IS NAV..")
            _  = q.viewControllers[0]
            current = q.viewControllers.first! 
        }
        return current
    }
    
    class func getNavigationController() -> UINavigationController?{
        let current =  UIApplication.sharedApplication().keyWindow!.rootViewController!
        if let q = current as? UINavigationController{
            return q
        }
        print("No navigation controller found..")
        return nil
    }
    
    
}