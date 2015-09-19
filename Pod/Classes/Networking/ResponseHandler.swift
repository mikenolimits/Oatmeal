//
//  ResponseHandler.swift
//  Pods
//
//  Created by Michael Kantor on 8/23/15.
//
//

import Foundation
import SwiftyJSON

#if !os(iOS)
 import AppKit
#else
 import UIKit
#endif

public struct ResponseHandler{
    public var success = false
    public var response: SwiftyJSON.JSON?
    public var responseString : String?
    public var responseUrl    : NSURL?
    public var statusCode : Int?
    public var headers : [NSObject : AnyObject]?
    public var cookies :[String : String]?
    public var error: ErrorType?
    public var message : String?
    
    #if !(iOS)
    public var image : [UInt8]?
    #else
    public var image : UIImage?
    #endif
}