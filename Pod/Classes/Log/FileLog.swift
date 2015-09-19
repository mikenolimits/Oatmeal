import Foundation

public class FileLog : Loggable
{
    public var location : String
    public var config : Configuration?
    
    public static var entityName : String?{
        return "filelog"
    }
    public var time : String
    public var type : LogType
    
	public required init()
	{
        let formatter         = NSDateFormatter()
        formatter.dateStyle   = NSDateFormatterStyle.FullStyle
        let currentTime       = NSDate()
        self.time             = formatter.stringFromDate(currentTime)
        self.type             = .Success
        self.location         = "App"
	}

	public func write(message:String)
	{
        //If file log is disabled we won't try to write to it.
        if let config = self.config, logEnabled = config.get("LOG_ENABLED") as? Bool where logEnabled == false
        {
            return
        }
        
		if let log = NSFileHandle(forUpdatingAtPath: self.location), oldText = NSString(data: log.readDataToEndOfFile(), encoding: NSUTF8StringEncoding)
		{
            let currentLog   = "\(oldText)[Time: \(time), Type: \(self.type)]: \(message)\n"
            let absolutePath = NSURL(fileURLWithPath: self.location)
            let fileHandle   = NSFileHandle(forWritingAtPath: absolutePath.path!)
            fileHandle?.writeData(currentLog.dataUsingEncoding(NSUTF8StringEncoding)!)
        }
	}
    
    public func success(message:String)
    {
        self.type = .Success
        self.write(message)
    }

    public func success<T:AnyObject>(message:[T])
	{
        self.type = .Success
        self.write(self.fromArray(message))
	}

	public func error(message:String)
	{
        self.type  = .Warning
        self.write(message)
	}

    public func error<T:AnyObject>(message:[T])
	{
        self.type  = .Warning
        write(fromArray(message))
	}
    
    func fromArray<T:AnyObject>(message:[T])->String
    {
        var messageToWrite = "[\(time)]:"
        
        for i in message
        {
            messageToWrite += String(i)
        }
        return messageToWrite
    }
    

    public func didBind()
    {
       
    }
    
    /*
       By the off chance Configuration isn't bound to the Container we will bind it to prevent a crash.
    */
    public func didResolve()
    {
        Oats().bindIf({!Oats().has("configuration")},
            withMember : Configuration.self,
            completion : {}
        )
        
        if let logLocation = self.config?.get("LOG_LOCATION") as? String
        {
            self.location     = logLocation
        }
        
    }
}

