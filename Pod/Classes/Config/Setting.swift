import Foundation


public struct Setting{

	 public let name   : String
	 public let cached : Bool
	//Can even be a Dictionary<KeyType, ValueType>
	 public let value  : Any
    /**
      namespace supports multiple plist files with name collisions
    **/
     public let namespace : String

    init(name:String, value : AnyObject, cached: Bool = false, namespace:String = ""){
		self.name      = name
		self.cached    = cached
        self.value     = value
        self.namespace = namespace
	}
    init(name:String, value : Any,cached : Bool = false, namespace : String = "")
    {
        self.name      = name
        self.cached    = cached
        self.value     = value
        self.namespace = namespace
    }

}
