import Foundation

public class Container : Oatmeal
{
    public static var entityName : String? = "Container"
    /* 
       The singleton reference to the container itself
    */
    
    static public let App = Container()
    
    
    /* 
       Singletons bound to the app always need a reference
    */
    public var singletons :  [Resolveable] = [Events(),Reflections()]
    
    /*
       Lazy members bound to the app do not need a reference, and will be deinitlized 
       whenever they are no longer needed.
    */
    private var members: [String:Resolveable.Type] = [String: Resolveable.Type]() {
        didSet {
            print(members, terminator: "\n")
        }
    }

    
    public required init()
    {
    
    }
    
    public func didResolve(member : Any)
    {
        if let proactiveMember = member as? ProactiveResolveable
        {
            proactiveMember.didResolve()
        }
        //We're going to ensure that all events are registered as soon as the class is resolved.
        if let eventUser = member as? UsesEvents
        {
            eventUser.setEvents()
        }
        
        if let autoresolver = member as? Autoresolves
        {
            injectDependencies(autoresolver)
        }
    }
    

    /*
       First we will check if the user provided an entityName, if they did, we will
       Use it. Otherwise we will get the name of the class instead.
    */
    
    public func get<O : Resolveable>() -> O?
    {
        guard let name = O.entityName else
        { 
            let name = String(O).lowercaseString
           
            return self.get(name) as? O
        }
        
        //are we certain this member exists?
        return self.get(name) as? O
    }
    
    /*
      First we will check for a framework bound member because it will be most common
      Second we we will check for user bound members.
    */
    public func get(key:String)->Resolveable?
    {
        if let member = members[key]
        {
            let entity = member.init()
            //The instance method for didResolve will only work with an itialized object
            self.didResolve(entity)
            return entity
        }
        
        if let member = singletons.find({$0.dynamicType.entityName == key})
        {
            //Singletons are always initialized
            self.didResolve(member)
            return member
        }
        else
        {
            print(ContainerException.DoesntExist(key: key).err)

            return nil
        }
    }
    
    public func has(key:String)-> Bool
    {
        return get(key) != nil
    }

    public func has(key:Resolveable.Type)-> Bool
    {
        if let entityName = key.entityName
        {
            return (get(entityName) != nil)
        }
        let dynamicName = "\(key.init().dynamicType)"
        
        return (get(dynamicName) != nil)
    }
    
    
    /*
       This is the "safe" bind method. If the developer makes their class Resolveable, and it has a custom entity name, it would be unlikely for a name collision to occur and for the class not to resolve later on. 
    */
    
    public func bind(key: String,member: Resolveable.Type)
    {
        self.members[key] = member
        
        if let proactiveMember = member as? ProactiveResolveable
        {
            proactiveMember.didBind()
        }
    }
    
    public func bind(member: Resolveable)
    {
       
        
        //Now that we have both the type and a reference to the class,
        //We can initialize it whenever its needed.
        let entity = member.dynamicType
        
        guard let name = member.dynamicType.entityName else{
            let dynamicName = "\(entity)".capitalizedString.stringByReplacingOccurrencesOfString(".Type",withString: "")
            self.members[dynamicName] = entity
            return
        }
        self.members[name] = entity
        
        //In case the developer wants to listen for the binding of their class
      
        if let proactiveMember = member as? ProactiveResolveable
        {
            proactiveMember.didBind()
        }
        
    }
    
    public func bindSingleton(singleton : Resolveable)
    {
        self.singletons.append(singleton)
    }
    
    public func bindIf(condition : () -> Bool, withMember : Resolveable.Type,completion : () -> ())
    {
        if(condition())
        {
            let entity = withMember.init()
            bind(entity)
            completion()
        }
    }
    
    public func register(providers  : [ServiceProvider])
    {
        for i in providers
        {
            register(i)
        }
    }
    
    public func register(provider: ServiceProvider)
    {
        for i in provider.provides
        {
            if let entityName = i.entityName
            {
                members[entityName] = i
            }
            else
            {
                let name = "\(i.dynamicType)".capitalizedString.stringByReplacingOccurrencesOfString(".Type",withString: "")
                members["\(name)"] = i
            }
        }

    }
    
    public func injectDependencies(obj: Autoresolves)
    {
        for (key,prop) in obj.dependencies()
        {
            if let resolved = ~key as? NSObject
            {
                obj.setValue(resolved, forKey: prop.label)
            }
        }
    }
    
    
    public func open(any: Any?) -> Any.Type
    {
        let mi = Mirror(reflecting: any)
        
        if let children = AnyRandomAccessCollection(mi.children)
        {
            for (_, value) in children
            {
                return value.dynamicType
            }
        }
        
        return mi.subjectType
    }
}
