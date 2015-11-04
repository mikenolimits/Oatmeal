import Foundation
import AlamofireImage

#if os(OSX)
    import AppKit
#endif
#if os(iOS) || os(tvOS)
    import UIKit
#endif
#if os(watchOS)
    import WatchKit
#endif

public class ImagePipeline : Resolveable
{
    public static var entityName : String?{
        return "imagepipeline"
    }

	public required init()
	{
        
	}
    
    #if os(OSX)
      //Step 1. Check if we can get the image from the cache 
      public func get(key:String)->NSImage?
      {
         return nil
      }
    
       #else
      public func get(key:String)->UIImage?
      {
         return nil
      }
   #endif    
}