//: Playground - noun: a place where people can play

import UIKit
import SpriteKit

let image = UIImage(named: "oatmeal")
let dict  : [String:AnyObject] = ["oatmeal" : image as! AnyObject]
let texture = SKTextureAtlas(dictionary: dict)

let SKText = texture.textureNamed("oatmeal")

let node = SKSpriteNode(texture: SKText)

//node.anchorPoint = CGPoint(x: 1, y: 1)
node.size   = CGSize(width: 400, height: 400)
let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)

node.runAction(action)
