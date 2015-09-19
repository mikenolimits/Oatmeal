import Foundation
import AlamofireImage

#if !os(iOS)
    import AppKit
    #else
    import UIKit
#endif

public class ImagePipeline : Resolveable
{
    public static var entityName : String?{
        return "imagepipeline"
    }

	public required init()
	{
        
	}
    
    #if !os(iOS)
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