import UIKit
import CoreMotion
import SceneKit
import SpriteKit

open class FactoryScene: SCNView{
	public init(){
		super.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20), options: [SCNView.Option.preferredRenderingAPI.rawValue: SCNRenderingAPI.metal.rawValue])
		
		super.scene = SCNScene(named: "Factory.scn")!
		autoenablesDefaultLighting = true
		allowsCameraControl = true
		
		guard let scene = super.scene else { return }
		scene.physicsWorld.contactDelegate = self
		
	}
	
	public func addMachine(_ machine: FunctionMachine){
		machine.node.position = SCNVector3(x: 0, y: 0, z: 0)
		scene?.rootNode.addChildNode(machine.node)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
extension FactoryScene: SCNPhysicsContactDelegate{
	public func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact){
		var box = contact.nodeA
		if(contact.nodeA.name == "conveyor"){
			box = contact.nodeB
		}else if(contact.nodeB.name != "conveyor"){
			return
		}
		box.geometry!.firstMaterial!.diffuse.contents = UIColor.yellow
	}
}
extension UIColor{
	static func random() -> UIColor{
		let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
		let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
		let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
		
		return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
	}
}
