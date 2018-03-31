import SceneKit

public class FunctionMachine{
    public let name: String
    public let f: (Int) -> Int
    
	var workInProgress = false
	var destroyed = false
	
	public let node: SCNNode
	
	public init(name: String, function: @escaping (Int) -> Int){
        self.name = name
        self.f = function
        
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
	
    public func process(node: SCNNode, out: Int){
        if node.position.x < 2{
            let input = SCNAction.move(to: SCNVector3(x: 4, y: 0.3, z: 0), duration: 0.75)
            node.runAction(input){
                //Set.. output value
                guard let diffuse = node.geometry?.firstMaterial?.diffuse else { return }
                guard let layer = diffuse.contents as? CALayer else { return }
                diffuse.contents = self.getTextLayer(value: String(out), color: layer.backgroundColor)
                
                let output = SCNAction.move(to: SCNVector3(x: 5.7, y: 0.3, z: 0), duration: 0.75)
                node.runAction(output)
            }
        }
    }
    
    private func getTextLayer(value: String, color: CGColor? = nil) -> CALayer{
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        layer.backgroundColor = (color != nil) ? color!: CGColor.random()
        
        let textLayer = CATextLayer()
        textLayer.frame = layer.frame
        textLayer.string = value
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.display()
        
        layer.addSublayer(textLayer)
        return layer
    }
	
    public func dropNumber(_ number: Int, output: Int){
		let box = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.1)
		box.firstMaterial?.transparency = 1
        box.firstMaterial?.diffuse.contents = getTextLayer(value: String(number))
        let child = createChildNode(val: output, geometry: box)
        node.addChildNode(child)
	}
    
    private func createChildNode(val: Int, geometry: SCNGeometry) -> SCNNode{
        let child = SCNNode(geometry: geometry)
        child.name = "numberbox_" + self.name + "_" + String(val)
        child.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        child.physicsBody!.isAffectedByGravity = true
        child.physicsBody!.categoryBitMask = 4
        child.physicsBody!.contactTestBitMask = 7
        child.physicsBody!.collisionBitMask = 7
        child.position = SCNVector3(x: 0, y: 5, z: 0)
        return child
    }
	
	public func setInProgress(_ value: Bool){
		workInProgress = value
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
extension CGColor{
    static func random() -> CGColor{
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1).cgColor
    }
}

