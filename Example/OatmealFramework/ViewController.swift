//
//  ViewController.swift
//  Oatmeal
//
//  Created by mikenolimits on 08/21/2015.
//  Copyright (c) 2015 mikenolimits. All rights reserved.
//

import UIKit
import OatmealFramework
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var Hello: UILabel!
    
    @IBOutlet weak var helloOatmeal: UIButton!
    
    @IBAction func bringTheOats(sender: AnyObject)
    {
        if let events : Events = ~Oats()
        {
            events.fire("sayHello", payload: ["view" : self])
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setEvents()
        self.checkDependencies()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setEvents()
    {
        if let events : Events = ~Oats(), http: Networking = ~Oats()
        {
            print("Listening for presented...")
            events.listenFor("presented", global: true, handler: {
                event in
                
                 self.request(http)
            })
        }
    }
    
    func request(http : Networking)
    {
        http.GET("https://api.github.com/repos/mikenolimits/OatmealFramework", completion: {
            handler in
            
            if let response = handler.response, github : Github = ~response, events : Events  = ~Oats()
            {
                events.fire("setText",payload : ["framework" : github, "view" : self])
            }
        })
    }
    
    func checkDependencies()
    {
        guard let _ : ViewPresentor = ~Oats() else
        {
            var presentor = ViewPresentor()
            presentor ~> Oats()
            return
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

