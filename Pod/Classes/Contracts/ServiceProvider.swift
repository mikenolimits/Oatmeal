//
//  ServiceProvider.swift
//  Pods
//
//  Created by Michael Kantor on 8/25/15.
//
//

import Foundation

public protocol ServiceProvider
{
    var provides : [Resolveable.Type] { get set}
}