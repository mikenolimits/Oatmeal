import Foundation


public protocol Loggable : Resolveable
{
	func success(message:String)
    func success<T:AnyObject>(message:[T])
	func error(message:String)
    func error<T:AnyObject>(message:[T])
}
