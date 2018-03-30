import UIKit
import CoreMotion
import SceneKit
import SpriteKit
import PlaygroundSupport

open class FactoryScene: SCNView, SCNSceneRendererDelegate, SCNPhysicsContactDelegate{
    var machines: [FunctionMachine] = []
    
	public init(){
		super.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20), options: [SCNView.Option.preferredRenderingAPI.rawValue: SCNRenderingAPI.metal.rawValue])
        self.scene = SCNScene(named: "Factory.scn")!
        self.scene!.physicsWorld.contactDelegate = self
		autoenablesDefaultLighting = true
		allowsCameraControl = true
		showsStatistics = true
	}
    
    func viewDidLoad(){
        self.scene!.physicsWorld.contactDelegate = self
    }
	
	public func addMachine(_ machine: FunctionMachine){
		machine.node.position = SCNVector3(x: 0, y: 0, z: Float(machines.count) * -5)
		scene?.rootNode.addChildNode(machine.node)
        machines.append(machine)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    public func getMachine(named: String) -> FunctionMachine?{
        for machine in machines{
            if machine.name == named{
                return machine
            }
        }
        return nil
    }
    
    public func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact){
        if contact.nodeA.name == "conveyor"{
            if contact.nodeB.name!.contains("numberbox"){
                if contact.nodeB.position.x < 2{
                    let process = SCNAction.move(to: SCNVector3(x: 5.7, y: 0.3, z: 0), duration: 1.5)
                    contact.nodeB.runAction(process)
                }
            }
        }
    }
}
extension FactoryScene: PlaygroundLiveViewMessageHandler{
    public func receive(_ message: PlaygroundValue){
        guard case let .dictionary(dict) = message else { return }
        guard case let .string(f)? = dict["machine"] else { return }
        guard case let .integer(n)? = dict["arg"] else { return }
        
        getMachine(named: f)?.dropNumber(n)
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
