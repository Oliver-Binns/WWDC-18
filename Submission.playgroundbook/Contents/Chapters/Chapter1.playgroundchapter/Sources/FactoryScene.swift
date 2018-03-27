import UIKit
import CoreMotion
import SceneKit
import SpriteKit

open class FactoryScene: SCNView{
	let motionManager = CMMotionManager()
	
	public init(){
		super.init(frame: CGRect(x: 0, y: 0, width: 750, height: 750), options: [SCNView.Option.preferredRenderingAPI.rawValue: SCNRenderingAPI.metal.rawValue])
		
		super.scene = SCNScene(named: "FunctionMachine.scn")
		autoenablesDefaultLighting = true
		allowsCameraControl = true
		
		guard let scene = super.scene else { return }
		
		//Add smoke-
		if let chimney = scene.rootNode.childNode(withName: "smoke", recursively: true){
			let smoke = SCNParticleSystem(named: "Smoke.scnp", inDirectory: nil)!
			chimney.addParticleSystem(smoke)
		}
		
	}
	
	public func addMachine(_ machine: FunctionMachine){
		machine.position = SCNVector3(x: 0, y: 0, z: 0)
		//scene?.rootNode.addChildNode(machine)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
