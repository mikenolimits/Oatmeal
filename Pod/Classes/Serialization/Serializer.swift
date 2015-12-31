
import Foundation
import SwiftyJSON

public class Serializer : Resolveable
{
    public static var entityName :String? = "serializer"
    
    public typealias params         = [String:AnyObject]
    public typealias j              = SwiftyJSON.JSON
    
    //This is really a counter of "how many function calls to parse are you willing to make"
    public var recursiveCalls : Int
    public var recursionLimit : Int
    
    public required init()
    {
       recursiveCalls = 0
       recursionLimit = 10
    }
    
    class func parse(object : Any)->Resolveable.Type?
    {
        if let _ = object as? MemoryCache
        {
            return MemoryCache.self
        }
        if let _ = object as? FileCache{
            return FileCache.self
        }
        if let _ = object as? Configuration
        {
            return Configuration.self
        }
        if let _ = object as? FileLog
        {
            return FileLog.self
        }
        if let _ = object as? Reachability
        {
            return Reachability.self
        }
        if let _ = object as? Networking
        {
            return Networking.self
        }
        if let _ = object as? HttpLog
        {
            return HttpLog.self
        }
        if let _ = object as? Serializer
        {
            return Serializer.self
        }
        
        return nil
    }
    
    public func parse(model: Modelable, JSON : j) -> Modelable?
    {
        let reflectedProperties = model.toProps()
        //var reflectedModels     = properties()
        if(recursiveCalls <= recursionLimit)
        {
            //Inject any depedencies from the container including submodels.
            for (key,prop) in model.dependencies(reflectedProperties)
            {
                if let resolved = ~key as? NSObject
                {
                    //Now lets check if the dependency we pulled is actually a model too!
                    print(resolved)
                    if let modelableMember = resolved as? Modelable
                    {
                        recursiveCalls++
                        let replaced = parse(modelableMember, JSON: JSON[prop.label])
                        model.setValue(replaced, forKey: prop.label)
                    }
                    else
                    {
                       model.setValue(resolved, forKey: prop.label)
                    }
                }
            }
            //Check for any models in layers below
            
            for (key,prop) in reflectedProperties
            {
                
                let jValue = JSON[key]
                let casted = cast(jValue, prop: prop)
                print(prop.type)
                
                if let _ = casted.find({prop.type == $0})
                {
                    switch(jValue.type)
                    {
                    case .Number:
                        
                        let assertMirror = Mirror(reflecting: jValue)
                        
                        if(assertMirror.displayStyle != .Optional)
                        {
                            model.setValue(jValue.numberValue, forKey: key)
                        }
                        
                    case .String:
                        model.setValue(jValue.stringValue, forKey: key)
                        
                    case .Bool:
                        model.setValue(jValue.boolValue, forKey: key)
                        
                    case .Array: break
                        //model.setValue(jValue.arrayValue, forKey: key)
                        
                    default:
                        break
                    }
                }
            }
        }
        return model
    }
    
    public func parse<T:Modelable>(JSON: j)->T?
    {
        if let model = parse(T.init(), JSON: JSON) as? T
        {
            //Reset Calls
            recursiveCalls = 0
            return model
        }
        return nil
    }
        
    public func serialize<T:Modelable>(json:params)->T?
    {
        let json = j(json)
        return self.parse(json)
    }
    
    public func serialize<T:Modelable>(json:j)->T?
    {
        return self.parse(json)
    }
    
    public func serialize<T:Modelable>(json:String)->T?
    {
        guard let dataFromString = json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) else
        {
            return nil
        }
        
        let json = JSON(data: dataFromString)
        return self.parse(json)
    }
    
    
    
    /*
    Will return all the types we can possibly cast the JSON value to.
    */
    func cast(uncasted: JSON, prop: Property) -> [Any.Type?]
    {
        var castable = [Any.Type?]()
        switch(uncasted.type)
        {
        case .Number,.String:
            castable = parseNumber(uncasted, castable: castable)
            castable = parseString(uncasted, castable: castable)
        case .Array:
            castable = parseArray(uncasted, castable: castable, prop: prop)
        default: break
        }
        /*
        for T : Any.Type in castable
        {
        let opt : T = nil
        let type = Mirror(reflecting: opt)
        castable.append(opt.dynamicType)
        }
        */
        return castable
    }
   
    func parseArray(uncasted: JSON, var castable:[Any.Type?], prop: Property) -> [Any.Type?]
    {
        for (_,value) in uncasted
        {
            if let asString = value.string where asString != ""
            {
                castable.append([String].self)
                castable.append([NSString].self)
            }
            if let _ = uncasted.double
            {
                castable.append(open([Double].self))
                castable.append([Double].self)
            }
            if let _ = uncasted.float
            {
                castable.append(open([Float]?))
                castable.append([Float].self)
            }
            if let _ = uncasted.int16
            {
                castable.append(open([Int16]?))
                castable.append([Int16].self)
            }
            if let _ = uncasted.int32
            {
                castable.append([Int32].self)
            }
            if let _ = uncasted.int64
            {
                castable.append([Int64].self)
            }
            if let _ = uncasted.int
            {
                castable.append([Int?].self)
                castable.append([Int].self)
            }
            
        }
    
        return castable
        
    }
    
    func parseString(uncasted: JSON, var castable:[Any.Type?]) -> [Any.Type?]
    {
        if let _ = uncasted.string
        {
            castable.append(String?.self)
            castable.append(String.self)
            castable.append(NSString.self)
        }
        return castable
    }
    
    func parseNumber(uncasted: JSON, var castable:[Any.Type?]) -> [Any.Type?]
    {
        
        if let _ = uncasted.double
        {
            castable.append(open(Double?))
            castable.append(Double.self)
        }
        if let _ = uncasted.float
        {
            castable.append(open(Float?))
            castable.append(Float.self)
        }
        if let _ = uncasted.int16
        {
            castable.append(open(Int16?))
            castable.append(Int16.self)
        }
        if let _ = uncasted.int32
        {
            castable.append(Int32.self)
        }
        if let _ = uncasted.int64
        {
            castable.append(Int64.self)
        }
        if let _ = uncasted.int
        {
            castable.append(Int?.self)
            castable.append(Int.self)
        }
        return castable
    }
    
    func open(any: Any?) -> Any.Type
    {
        return Serializer.open(any)
    }
    
    /*
        Simple class func to get the dynamicType of any object. Can be used recursively
        - parameter : Any
    */
    class func open(any: Any?) -> Any.Type
    {
        return Oats().open(any)
    }
    
}
