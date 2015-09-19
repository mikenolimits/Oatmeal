//
//  ViewController.swift
//  Oatmeal
//
//  Created by mikenolimits on 08/21/2015.
//  Copyright (c) 2015 mikenolimits. All rights reserved.
//

import UIKit
import Oatmeal
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var Hello: UILabel!
    
    @IBOutlet weak var helloOatmeal: UIButton!
    
    var events : Events? = ~App()
    
    @IBAction func bringTheOats(sender: AnyObject)
    {
        if let events : Events = ~App()
        {
            events.fire("sayHello", object: ["view" : self])
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setEvents()
        self.checkDependencies()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setEvents(){
        if let events : Events = ~App(), http: Networking = ~App()
        {
            events.listenFor("presented", global: true, handler: {
                event in
                
                http.GET("https://api.github.com/repos/mikenolimits/OatmealFramework", type: RequestType.ShouldSendUrlAndReturnJson, parameters: nil, completion: {
                    handler in
                    
                    if let response = handler.response
                    {
                        print(response)
                    }
                    
                })
                
            })
        }
    }
    
    func checkDependencies()
    {
        guard let _ : ViewPresentor = ~App() else {
            var presentor = ViewPresentor()
            presentor ~> App()
            return
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

