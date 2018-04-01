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
		allowsCameraControl = true
	}
    
    func viewDidLoad(){
        self.scene!.physicsWorld.contactDelegate = self
    }
	
	public func addMachine(_ machine: FunctionMachine){
		machine.node.position = SCNVector3(x: 3.5, y: 0, z: Float(machines.count) * -5)
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
            guard let name = contact.nodeB.name else { return }
            if name.contains("numberbox"){
                let data = name.split(separator: "_")
                let machine = getMachine(named: String(data[1]))!
                let out: Int? = Int(data[2])
                machine.process(node: contact.nodeB, out: out, renderer: self)
            }
        }
    }
}
extension FactoryScene: PlaygroundLiveViewMessageHandler{
    public func receive(_ message: PlaygroundValue){
        guard case let .dictionary(dict) = message else { return }
        
        guard case let .string(f)? = dict["machine"] else { return }
        guard case let .integer(n)? = dict["arg"] else { return }
        
        guard case let .integer(out)? = dict["ret"] else {
            getMachine(named: f)?.dropNumber(n, output: nil, renderer: self)
            return
        }
        getMachine(named: f)?.dropNumber(n, output: out, renderer: self)
    }
}
