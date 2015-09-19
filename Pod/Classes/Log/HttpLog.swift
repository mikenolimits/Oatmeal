import Foundation

public class HttpLog : Loggable{

	let networking : Networking    = (~Oats())!
    let config     : Configuration = (~Oats())!
    let route: Route
    
    public static var entityName : String?{
        return "httplog"
    }
    
    
    public required init()
    {
        guard let baseUrl = self.config.get("HTTP_LOG_URL") as? String else {
            self.route = Route(baseUrl: "", endpoint: nil, type: nil)
            return
        }
        self.route      = Route(baseUrl: baseUrl, endpoint: nil, type: nil)
    }
    
    init(url:String)
	{
        //Initilize an empty route so we can send our log information to it later.
        self.route = Route(baseUrl: url, endpoint: nil, type: nil)
	}
    
    init(route:Route)
    {
        self.route = route
    }

	public func success(message:String)
	{


	}

    public func success<T:AnyObject>(message:[T])
	{

	}

	public func error(message:String)
	{

	}

    public func error<T:AnyObject>(message:[T])
	{

	}
    
    public func didBind()
    {
    
        
    }
    
    public func didResolve()
    {
        
        
    }
}
