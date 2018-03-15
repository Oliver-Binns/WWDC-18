import UIKit
import CoreMotion
import SceneKit
import SpriteKit
import PlaygroundSupport

class FactoryScene: SCNView{
	let cameraNode = SCNNode()
	
	init(){
		super.init(frame: CGRect(x: 0, y: 0, width: 750, height: 750), options: [SCNView.Option.preferredRenderingAPI.rawValue: SCNRenderingAPI.metal.rawValue])
		super.scene = SCNScene()
		autoenablesDefaultLighting = true
		
		cameraNode.camera = SCNCamera()
		cameraNode.light = SCNLight()
		cameraNode.light?.type = .ambient
		cameraNode.light?.color = UIColor.white
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 100)
		scene?.rootNode.addChildNode(cameraNode)
		
		self.backgroundColor = UIColor.gray
	}
	
	func updateCamera(dx: CGFloat, dy: CGFloat, dz: CGFloat){
		cameraNode.runAction(SCNAction.rotateTo(
			x: dx / 10,
			y: dy / 10,
			z: dz / 10,
			duration: 0.2
		))
	}
	
	func addMachine(_ machine: SCNNode){
		scene?.rootNode.addChildNode(machine)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


PlaygroundPage.current.needsIndefiniteExecution = true
let scene = FactoryScene()

let text = SCNText(string: "Test", extrusionDepth: 20)
text.firstMaterial?.transparency = 1
text.firstMaterial?.diffuse.contents = UIColor.red
let machine = SCNNode(geometry: text)
machine.position = SCNVector3(x: 0, y: 0, z: 0)
scene.addMachine(machine)

let motionManager = CMMotionManager()
motionManager.deviceMotionUpdateInterval = 0.2
if motionManager.isAccelerometerAvailable{
	var initial: SCNVector3?
	motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {
		(motion: CMAccelerometerData?, error: Error?) in
		guard let acc = motion?.acceleration else { return }
		guard let start = initial else { initial = SCNVector3(x: Float(acc.x), y: Float(acc.y), z: Float(acc.z)); return }
		
		// Rotating the camera based on motion
		scene.updateCamera(
			dx: CGFloat(acc.x - Double(start.x)),
			dy: CGFloat(acc.y - Double(start.y)),
			dz: CGFloat(acc.z - Double(start.z))
		)
	})
}

PlaygroundPage.current.liveView = scene
