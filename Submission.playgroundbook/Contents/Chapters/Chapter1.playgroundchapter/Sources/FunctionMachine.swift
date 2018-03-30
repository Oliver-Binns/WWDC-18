import SceneKit

public class FunctionMachine{
    public let name: String
    
	var workInProgress = false
	var destroyed = false
	
	public let node: SCNNode
	
	public init<A, B>(name: String, function: (A) -> B){
        self.name = name
        
		let scene = SCNScene(named: "FunctionMachine.scn")!
        node = scene.rootNode
        if let conveyor = node.childNode(withName: "conveyor", recursively: true){
            let physics = SCNPhysicsBody(type: .kinematic, shape: nil)
            physics.categoryBitMask = 2
            physics.contactTestBitMask = 7
            physics.collisionBitMask = 7
            conveyor.physicsBody = physics
        }
		
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
	
	
    
    private func getTextLayer(value: String) -> CALayer{
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        layer.backgroundColor = UIColor.random().cgColor
        
        let textLayer = CATextLayer()
        textLayer.frame = layer.frame
        textLayer.string = value
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.display()
        
        layer.addSublayer(textLayer)
        return layer
    }
	
	public func dropNumber(_ number: Int){
		let box = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.1)
		box.firstMaterial?.transparency = 1
        box.firstMaterial?.diffuse.contents = getTextLayer(value: String(number))
        createChildNode(val: number, geometry: box)
	}
    
    private func createChildNode(val: Int, geometry: SCNGeometry){
        let child = SCNNode(geometry: geometry)
        child.name = "numberbox_" + self.name + "_" + String(val)
        child.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        child.physicsBody!.isAffectedByGravity = true
        child.physicsBody!.categoryBitMask = 4
        child.physicsBody!.contactTestBitMask = 7
        child.physicsBody!.collisionBitMask = 7
        child.position = SCNVector3(x: 0, y: 5, z: 0)
        node.addChildNode(child)
    }
	
	public func setInProgress(_ value: Bool){
		workInProgress = value
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
