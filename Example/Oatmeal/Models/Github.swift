import Foundation
import Oatmeal

class Github:Model
{
    var name   :String?
    var language : String?
    var owner : Owner?
    var cache : MemoryCache?
    var log  : FileLog?
    
    required init()
    {
        super.init()
    }

    required init(data: [String : AnyObject])
    {
        super.init(data: data)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    override func setValue(value: AnyObject!, forUndefinedKey key: String)
    {
        if let v = value as? MemoryCache
        {
            self.cache = v
        }
        if let v =  value as? FileLog
        {
            self.log   = v
        }
    }
*/
}