import Alamofire
import Async
import Foundation
import OatmealFramework
import OatmealFramework.Swift
import SwiftyJSON

let file = FileCache()

func cast(uncasted: Any) -> Any.Type
{
    if let _ = Int("\(uncasted)"){
        return Int.self
    }
    if let _ = uncasted as? Double{
        return Double.self
    }
    if let _ = uncasted as? String{
        return String.self
    }
    
    return NSNull.self
}

func open(any: Any?) -> Any.Type
{
    let mirror = Mirror(reflecting: any)
    
    if let children = AnyRandomAccessCollection(mirror.children)
    {
        for (_, value) in children
        {
            return value.dynamicType
        }
    }
    
    return mirror.subjectType
}


class Person : Model
{
    var name  : String?
    var type  : String?
    var lives : Int = 0
    var networking : Networking?
}

let route =  Route(baseUrl: "https://api.github.com/repos/mikenolimits/OatmealFramework", endpoint: nil, type: nil)

let dict       = ["name" : "bob", "type" : "person", "lives" : 10]
var jData      = JSON(dict)
let serializer = Serializer()

print("Hello")


//var person = Person()
//person ~> jData

if let model : Person = ~jData
{
    let intType = open(model.lives)
    print(model.type)
    print(model.name)
    print(model.lives)
}
