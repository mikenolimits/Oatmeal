//
//  Networking.swift
//  Pods
//
//  Created by Michael Kantor on 8/23/15.
//
//

import Foundation
import Alamofire
<<<<<<< HEAD
import AlamofireImage
=======
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
import SwiftyJSON

public class Networking : Resolveable
{
<<<<<<< HEAD
    public static var entityName : String?{
        return "networking"
    }
    public var manager  : Alamofire.Manager?
    
    public required init()
    {
        
    }
    
    func fireAs(method: Alamofire.Method,url:String, type: RequestType? = nil, parameters : [String:String]? = nil,completion:(response: ResponseHandler) -> Void )
    {
        let requestType : RequestType = type ?? .ShouldSendUrlAndReturnJson
        
        var route = Route(method: method, baseUrl: url, endpoint: nil, type: requestType)
        
        if let params = parameters
        {
            route.parameters = params
        }
        
        return fire(route,completion:completion)
=======
    public var entityName : String? = "networking"
    
    
    public required init()
    {
        
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
        
    }
    
    public func fire(route : Route, completion:(response: ResponseHandler) -> Void)
    {
<<<<<<< HEAD
=======
        var manager : Alamofire.Manager
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
        
        //First we create the context of the request
        //Allowing for the developer to have full control over the request
        
<<<<<<< HEAD
        if let config  = route.customConfiguration
        {
            self.manager = Alamofire.Manager(configuration: config, serverTrustPolicyManager: nil)
=======
        
        if let config  = route.customConfiguration
        {
            manager = Alamofire.Manager(configuration: config, serverTrustPolicyManager: nil)
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
        }
        else
        {
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
<<<<<<< HEAD
            config.timeoutIntervalForResource = 600
            config.HTTPAdditionalHeaders      = Manager.defaultHTTPHeaders
            
            self.manager = Alamofire.Manager(configuration: config, serverTrustPolicyManager: route.sslPolicy)
=======
            config.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders

            
            manager = Alamofire.Manager(configuration: config, serverTrustPolicyManager: route.sslPolicy)
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
        }
        
        switch(route.type)
        {
         case .ShouldSendUrlAndReturnJson, .ShouldSendJsonAndReturnIt:
            
<<<<<<< HEAD
            manager!.request(route.compose()).responseJSON { request, response, result in
                let handler = self.getHandler(response,result: result)
                //handler     = self.adjustToExpectation(route, handler: handler)
                completion(response: handler)
            }
         case .ShouldSendJsonAndReturnString,.ShouldSendUrlAndReturnString:
            manager!.request(route.compose()).responseString{ request, response, result in
=======
            manager.request(route.compose()).responseJSON { request, response, result in
                var handler = self.getHandler(response,result: result)
                handler     = self.adjustToExpectation(route, handler: handler)
                completion(response: handler)
            }
         case .ShouldSendJsonAndReturnString,.ShouldSendUrlAndReturnString:
            manager.request(route.compose()).responseString{ request, response, result in
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
                var handler = self.getHandler(response,result: result)
                handler     = self.adjustToExpectation(route, handler: handler)
                
                completion(response: handler)
            }
        }
        
    }
    
    func adjustToExpectation(route:Route, var handler:ResponseHandler)->ResponseHandler
    {
        switch(route.type)
        {
            case .ShouldSendUrlAndReturnJson, .ShouldSendJsonAndReturnIt:
                //Oh look here, we have no json, lets fix that.
                guard let _ = handler.response else{
<<<<<<< HEAD
                    let msg   = ["data" : ["message" : "No response recieved"]]
                    let json : JSON = JSON(msg)
                    handler.response = json
                    return handler
                }
=======
                    let json : JSON = ["data" : ["message" : "No response recieved"]]
                    handler.response = json
                    return handler
            }
            
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
            
            case .ShouldSendJsonAndReturnString,.ShouldSendUrlAndReturnString:
            
                guard let _ = handler.responseString else{
                    handler.responseString = "No Response recieved"
                    return handler
                }
            
        }
        
<<<<<<< HEAD
=======
        
        
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
        return handler
    }
    
    
    func getHandler(response: NSHTTPURLResponse?,result : Result<String>)->ResponseHandler
    {
        var handler = ResponseHandler()
        switch result {
        case .Success(let data):
    
            handler.responseString   = data
            handler.success          = true
            
        case .Failure(let data, let error):
            handler.message = "Request failed with error: \(error)"
            handler.error   = error
            
            if let data = data {
                handler.responseString =  ("\(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
                handler.response       = SwiftyJSON.JSON(data)
            }
            handler.success  = false
        }
        handler.headers    = response?.allHeaderFields
        handler.statusCode = response?.statusCode
        
        return handler
    }
    
    func getHandler(response: NSHTTPURLResponse?,result : Result<AnyObject>)->ResponseHandler
    {
        var handler = ResponseHandler()
        switch result {
        case .Success(let data):
<<<<<<< HEAD
=======
            /* parse your json here with swiftyjson */
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
            let data           = SwiftyJSON.JSON(data)
            handler.response   = data
            handler.headers    = response?.allHeaderFields
            
        case .Failure(let data, let error):
            handler.message = "Request failed with error: \(error)"
            handler.error   = error
            
            if let data = data {
                handler.responseString =  ("\(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
                handler.response       = SwiftyJSON.JSON(data)
            }
        
        }
        handler.headers    = response?.allHeaderFields
        handler.statusCode = response?.statusCode
        return handler
    }
}


extension Networking{
    
<<<<<<< HEAD
    public func GET(url:String, type: RequestType? = nil, parameters : [String:String]? = nil,completion:(response: ResponseHandler) -> Void)
    {
        return fireAs(.GET, url: url, type: type, parameters: parameters,completion: completion)
    }
    
    public func PUT(url:String, type: RequestType? = nil, parameters : [String:String]? = nil,completion:(response: ResponseHandler) -> Void)
    {
        return fireAs(.PUT, url: url, type: type, parameters: parameters,completion: completion)
    }
    
    public func POST(url:String, type: RequestType? = nil, parameters : [String:String]? = nil,completion:(response: ResponseHandler) -> Void)
    {
        return fireAs(.PUT, url: url, type: type, parameters: parameters,completion: completion)
    }

    public func DOWNLOAD(image:String,completion:(response: ResponseHandler) -> Void)
    {
        let downloader = ImageDownloader()
        if let url = NSURL(string: image)
        {
            let request    = NSURLRequest(URL:url)
            downloader.downloadImage(URLRequest: request, completion: { request,response,result in
                
                
            })
        }
        
    }

}
=======
    
    public func GET(url:String, type: RequestType, parameters : [String:String]?,completion:(response: ResponseHandler) -> Void){
        
        let route = Route(method: .GET, baseUrl: url, endpoint: nil, type: type)
        
        if let params = parameters
        {
            route.parameters = params
        }
        
        return fire(route,completion:completion)
    }
    

}
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
