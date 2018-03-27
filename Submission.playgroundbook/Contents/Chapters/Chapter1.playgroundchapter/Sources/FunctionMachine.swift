import SceneKit

public class FunctionMachine{
	var workInProgress = false
	var destroyed = false
	
	public let node: SCNNode
	
	public init<A, B>(name: String, function: (A) -> B){
		let scene = SCNScene(named: "FunctionMachine.scn")!
		node = scene.rootNode
		
		//Add smoke-
		if let chimney = node.childNode(withName: "smoke", recursively: true){
			let smoke = SCNParticleSystem(named: "Smoke.scnp", inDirectory: nil)!
			chimney.addParticleSystem(smoke)
		}
	}
	
	public func destroy(){
		let fire = SCNParticleSystem(named: "Fire.scnp", inDirectory: nil)!
		node.childNode(withName: "smoke", recursively: true)?.removeFromParentNode()
		node.childNode(withName: "capsule", recursively: true)?.addParticleSystem(fire)
	}
	
	private func createChildNode(x : Float = 0, y: Float = 0, z: Float = 0, geometry: SCNGeometry){
		let child = SCNNode(geometry: geometry)
		child.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: geometry))
		child.physicsBody?.isAffectedByGravity = true
		child.position = SCNVector3(x: x, y: y, z: z)
		node.addChildNode(child)
	}
	
	public func dropNumber(_ number: Int){
		let box = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.1)
		box.firstMaterial?.transparency = 1
		box.firstMaterial?.diffuse.contents = UIColor.random()
		createChildNode(y: 5, geometry: box)
	}
	
	public func setInProgress(_ value: Bool){
		workInProgress = value
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
