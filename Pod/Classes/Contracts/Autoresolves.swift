//
//  Autoresolves.swift
//  Pods
//
//  Created by Michael Kantor on 12/15/15.
//
//

import Foundation

public protocol Autoresolves : Resolveable, NSObjectProtocol
{
    /**
     - parameter value: The Value being set on the Model
     - parameter key : The name of the variable on the model being set
     **/
    func setValue(value: AnyObject?, forKey key: String)
}
