
import Foundation
import SwiftyJSON

public class Serializer : Resolveable
{
    public static var entityName :String?{
        return "serializer"
    }
    public typealias params         = [String:AnyObject]
    public typealias j              = SwiftyJSON.JSON
    
    public required init()
    {
        
    }
    
    public func parse<T:Modelable>(JSON: j)->T?
    {
        let model = T()
        let reflectedProperties = toProps(model)
        
        //1. Check for properties that might also be in the container.
        
        let resolveableTypes    = model.dependsOn()
        print("Resolable are...:")
        print(resolveableTypes)
        
        
        for(key,value) in JSON
        {
            let casted  = cast(value)

            
            if let jValue  = reflectedProperties[key] where (casted.find({$0 == jValue.type}) != nil)
            {
                switch(value.type)
                {
                  case .Number:
                    
                    let assertMirror = Mirror(reflecting: jValue)
                    print("Display style is \(assertMirror.displayStyle)")
                      
                    if(assertMirror.displayStyle != .Optional)
                    {
                        model.setValue(value.numberValue, forKey: key)
                    }
                    
                   case .String:
                      model.setValue(value.stringValue, forKey: key)
                   
                   case .Bool:
                       model.setValue(value.boolValue, forKey: key)
                    
                   default:
                      break
                  }
                }
           
        }
        print(model)
        return model
        
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
    func cast(uncasted: JSON) -> [Any.Type?]
    {
        var castable = [Any.Type?]()
        switch(uncasted.type)
        {
        case .Number,.String:
            castable = parseNumber(uncasted, castable: castable)
            castable = parseString(uncasted, castable: castable)
        //case .Array:
            //castable = parseArray(uncasted, castable: castable)
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
   /*
    func parseArray(uncasted: JSON, var castable:[Any.Type?]) -> [Any.Type?]
    {
        /*
        var stillParsable = true
        
        if let array  =  uncasted.array
        {
            for i in array where stillParsable
            {
                
                var arrayCastable = parseNumber(i, castable: castable)
                arrayCastable     = parseString(i, castable: castable)
                
               
                for i in arrayCastable{
                   
                }
                
            }
            
        }
        */
        return castable
        
    }
    */
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
