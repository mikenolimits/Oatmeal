//
//  ViewPresentor.swift
//  Oatmeal
//
//  Created by Michael Kantor on 8/24/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Oatmeal

class ViewPresentor : ProactiveResolveable{
    
    var entityName  : String? = "viewpresentor"
    
    
    required init()
    {
        
    }
    
    func render(view : ViewController)
    {
        UIView.animateWithDuration(5.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                view.Hello.alpha         = 0
                view.Hello.text          = "And then there was Oatmeal..."
                view.view.backgroundColor  = UIColor.blueColor()
                view.view.layoutIfNeeded()
            },completion: nil)
        
         UIView.animateWithDuration(5.5, delay: 2.0, options: UIViewAnimationOptions.CurveLinear,animations: {
            view.Hello.alpha = 1
            view.Hello.textColor = UIColor.whiteColor()
            let image = UIImage(named: "oatmeal")
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: view.view.frame.midX, y: view.view.frame.midY, width: 100, height: 100)
            view.helloOatmeal.alpha = 0
            view.view.addSubview(imageView)
            view.view.addSubview(view.Hello)
            
        },completion: nil)
            
        
        if let events : Events = ~App()
        {
          events.fire("presented")
        }
    }
    
    func didBind()
    {
        if let events : Events = ~App()
        {
            events.listenFor("sayHello", global: true, handler: {
                event in
                
                if let data = event.data, view = data["view"] as? ViewController
                {
                    self.render(view)
                }
            })
        }
    }
    
    func didResolve(){
        print("I have been resolved")
    }
}