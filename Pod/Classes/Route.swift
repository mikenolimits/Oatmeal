//
//  Route.swift
//  Pods
//
//  Created by Michael Kantor on 8/23/15.
//
//

import Foundation
import Alamofire

public class Route{
 
    let baseUrl : String
    let endpoint: String?
    var method : Alamofire.Method
    var parameters : [String:String]
    var customConfiguration : NSURLSessionConfiguration?
    var sslPolicy : ServerTrustPolicyManager?
    var type : RequestType
    var URLRequest: NSURLRequest?
    
    public init(baseUrl:String,endpoint:String?,type:RequestType?){
        self.method     = .GET
        self.parameters = [String:String]()
        self.baseUrl    = baseUrl
        self.endpoint   = endpoint
        
        if let kind = type
        {
            self.type = kind
        }
        else
        {
            self.type = RequestType.ShouldSendUrlAndReturnJson
        }
    }
    
    public init(method: Alamofire.Method, baseUrl:String,endpoint:String?,type:RequestType?){
        self.method     = method
        self.parameters = [String:String]()
        self.baseUrl    = baseUrl
        self.endpoint   = endpoint
        
        if let kind = type
        {
            self.type = kind
        }
        else{
            self.type = RequestType.ShouldSendUrlAndReturnJson
        }
    }
    
    func compose()->URLRequestConvertible
    {
        var encoding : ParameterEncoding
        
        switch(self.type)
        {
           case RequestType.ShouldSendUrlAndReturnJson,RequestType.ShouldSendUrlAndReturnString:
                encoding = ParameterEncoding.URL
            case RequestType.ShouldSendJsonAndReturnIt,.ShouldSendJsonAndReturnString:
                encoding = ParameterEncoding.JSON
        }
        
        let URL = NSURL(string : self.baseUrl)!
        var mutableURLRequest :  NSMutableURLRequest
        
        if let path = self.endpoint
        {
            mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        }
        else
        {
            mutableURLRequest  = NSMutableURLRequest(URL: URL)
        }
        
        mutableURLRequest.HTTPMethod = method.rawValue
        
        return encoding.encode(mutableURLRequest, parameters: parameters).0
        
    }

}