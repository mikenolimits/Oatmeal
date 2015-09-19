//
//  Model.swift
//  Poke
//
//  Created by Michael Kantor on 2/26/15.
//  Copyright (c) 2015 Michael Kantor. All rights reserved.
//

import Foundation
import Async

public class Model{
    
    public var events   : Events?
    // the unique id representing the model
    public var id       : Int?
    public var reloaded : Bool
    public var maxPages : Int
    
    
    public var pages: [Int] = [Int]() {
        willSet(newValue)
        {
            if (!pages.contains(currentPage))
            {
                getCollection()
                if let events = self.events
                {
                    events.fire("modelRetrieved")
                }
            }
        }
        didSet
        {
            pages = pages.unique()
        }
    }
    
    
    public var currentPage: Int = 1 {
        didSet {
            if currentPage <= 0 {
                currentPage = 1
            }
            if currentPage > maxPages {
                currentPage = maxPages
            }
        }
    }
    
    public var totalItems: NSMutableDictionary = [1: 0]
    
    public init()
    {
        self.reloaded = false
        self.maxPages = 1
        
        if let events : Events = ~App()
        {
           events.listenFor("requestModel", handler : { (event) in
               self.getCollection()
           })
        }
       
        reloadModel()
    }
    
    
    /*
        Essentially these method depend on where your data is hosted.
        Wether you use HTTP, CoreData, SQL, Cache, it won't care.
    */
    public func getCollection()
    {
        fatalError("This method must be overriden")
    }
    
    
    public func find(key: String) -> [AnyObject]?
    {
        fatalError("This method must be overriden")
    }
    
    
    public func reloadModel() {
        
        if let reachability : Reachability = ~App()
        {
            if(reachability.isConnected())
            {
                Async.background(after: 400.0)
                {
                    self.getCollection()
                    self.reloadModel()
                }
            }
        }
        else
        {
            self.reloadModel()
        }
    }
    
    
   
    
}
