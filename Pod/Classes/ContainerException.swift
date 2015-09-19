//
//  MemberNotFound.swift
//  Pods
//
//  Created by Michael Kantor on 8/23/15.
//
//

import Foundation


<<<<<<< HEAD

public enum ContainerException{
    
=======
enum ContainerException : ErrorType{
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
    
    case DoesntExist(key:String)
    case InvalidType(member:Any)
    
<<<<<<< HEAD
    /*
    public typealias RawValue = NullElement
    
    public  var rawValue: RawValue{
        return  NullElement(description: description,error:key)
    }
    
    public init?(rawValue: RawValue)
    {
        self = ContainerException.DoesntExist(key: "undefined")
    }
*/
    var key : String {
        switch self{
        case .DoesntExist(let key):
            return key
        case .InvalidType(let member):
            return String(member)
        }
    }
    

    var err : String
    {
        switch self{
=======
    func description() -> String
    {
      switch self{
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
          case .DoesntExist(let key):
              return "Member of name \(key) does not exist in the container"
          case .InvalidType(let member):
             let name = String(member)
             return "Member of type \(name) does not exist in the container"
<<<<<<< HEAD
      }
    }
    
=======
       }
    }
>>>>>>> 3feadc1ac1c07cd95104e2d326bcbc82aae70e5e
}