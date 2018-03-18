import UIKit
import CoreMotion
import SceneKit
import SpriteKit

public class FactoryScene: SCNView{
	let cameraNode = SCNNode()
	let motionManager = CMMotionManager()
	
	public init(){
		super.init(frame: CGRect(x: 0, y: 0, width: 750, height: 750), options: [SCNView.Option.preferredRenderingAPI.rawValue: SCNRenderingAPI.metal.rawValue])
		super.scene = SCNScene()
		
		self.startCameraUpdates()
		autoenablesDefaultLighting = true
		
		cameraNode.camera = SCNCamera()
		cameraNode.light = SCNLight()
		cameraNode.light?.type = .directional
		cameraNode.light?.color = UIColor.white
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 100)
		scene?.rootNode.addChildNode(cameraNode)		
	}
	
	private func startCameraUpdates(){
		motionManager.deviceMotionUpdateInterval = 0.2
		if motionManager.isAccelerometerAvailable{
			var initial: SCNVector3?
			motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {
				(motion: CMAccelerometerData?, error: Error?) in
				guard let acc = motion?.acceleration else { return }
				guard let start = initial else { initial = SCNVector3(x: Float(acc.x), y: Float(acc.y), z: Float(acc.z)); return }
				
				// Rotating the camera based on motion
				self.updateCamera(
					dx: CGFloat(acc.x - Double(start.x)),
					dy: CGFloat(acc.y - Double(start.y)),
					dz: CGFloat(acc.z - Double(start.z))
				)
			})
		}
	}
	
	private func updateCamera(dx: CGFloat, dy: CGFloat, dz: CGFloat){
		cameraNode.runAction(SCNAction.rotateTo(
			x: dx / 10,
			y: dy / 10,
			z: dz / 10,
			duration: 0.2
		))
	}
	
	public func addMachine(_ machine: FunctionMachine){
		machine.position = SCNVector3(x: 0, y: 0, z: 0)
		scene?.rootNode.addChildNode(machine)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
