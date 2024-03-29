import SceneKit

public class FunctionMachine{
    public let name: String
    public let f: (Int) -> Int?
    private var toProcess: [SCNNode] = []
    let scale = SCNVector3(0.2, 0.2, 0.2);
    
	var workInProgress = false
	private var destroyed = false
	
	public let node: SCNNode
	
	public init(name: String, function: @escaping (Int) -> Int?){
        self.name = name
        self.f = function
        
		let scene = SCNScene(named: "FunctionMachine.scn")!
        node = scene.rootNode.childNode(withName: "machine", recursively: true)!
        node.scale = scale
        if let conveyor = node.childNode(withName: "conveyor", recursively: true){
            let physics = SCNPhysicsBody(type: .kinematic, shape: nil)
            physics.categoryBitMask = 2
            physics.contactTestBitMask = 7
            physics.collisionBitMask = 7
            physics.restitution = 0
            conveyor.physicsBody = physics
        }
        
        //Setup display-
        let display = node.childNode(withName: "display", recursively: true)!
        display.geometry?.firstMaterial?.diffuse.contents = getTextLayer(value: String(name), color: #colorLiteral(red: 0.04705882353, green: 0.3450980392, blue: 0.8156862745, alpha: 1).cgColor, textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
		
		//Add smoke-
		if let chimney = node.childNode(withName: "smoke", recursively: true){
			let smoke = SCNParticleSystem(named: "Smoke.scnp", inDirectory: nil)!
			chimney.addParticleSystem(smoke)
		}
	}
	
	public func destroy(){
        guard !self.destroyed else { return }
        self.destroyed = true
        
		node.childNode(withName: "smoke", recursively: true)?.removeFromParentNode()
        
        guard let cylinder = node.childNode(withName: "main", recursively: true) else { return }
        
        
        let fire = SCNParticleSystem(named: "Fire.scnp", inDirectory: nil)!
        cylinder.addParticleSystem(fire)
        
        //CAUSES CRASH, could not diagnose in time :(
        //let audio = SCNAudioSource(named: "Fire.mp3")!
        //audio.isPositional = true
        //audio.shouldStream = true
        //let sound = SCNAction.playAudio(audio, waitForCompletion: true)
        //cylinder.runAction(sound)
	}
	
    public func process(node: SCNNode, out: Int?, renderer: SCNSceneRenderer){
        //Only process each item once
        guard let index = toProcess.index(of: node) else { return }
        toProcess.remove(at: index)
        
        let input = SCNAction.move(to: SCNVector3(x: 0.25, y: 0.15, z: 0), duration: 0.75)
        node.runAction(input){
            guard out != nil else { self.destroy(); return }
            //Set.. output value
            guard let material = node.geometry?.firstMaterial else { return }
            guard let layer = material.diffuse.contents as? CALayer else { return }
            material.diffuse.contents = self.getTextLayer(value: String(out!), color: layer.backgroundColor)
            renderer.prepare(material, shouldAbortBlock: { return false })
            
            //https://www.freesoundeffects.com
            let audio = SCNAudioSource(named: "Process.mp3")!
            audio.isPositional = true
            audio.shouldStream = true
            let sound = SCNAction.playAudio(audio, waitForCompletion: true)
            node.runAction(sound){
                let output = SCNAction.move(to: SCNVector3(x: 1, y: 0.15, z: 0), duration: 0.75)
                node.runAction(output){
                    node.physicsBody?.velocity = SCNVector3(0,0,0)
                }
            }
            
        }
    }
    
    private func getTextLayer(value: String, color: CGColor? = nil, textColor: CGColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor) -> CALayer{
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        layer.backgroundColor = (color != nil) ? color!: CGColor.random()
        
        let textLayer = CATextLayer()
        textLayer.frame = layer.frame
        textLayer.string = value
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.foregroundColor = textColor
        textLayer.isWrapped = true
        textLayer.display()
        
        layer.addSublayer(textLayer)
        return layer
    }
	
    public func dropNumber(_ number: Int, output: Int?, renderer: SCNSceneRenderer){
		let box = SCNBox(width: 0.25, height: 0.25, length: 0.25, chamferRadius: 0.05)
		box.firstMaterial!.transparency = 1
        box.firstMaterial!.diffuse.contents = getTextLayer(value: String(number))
        renderer.prepare(box.firstMaterial!, shouldAbortBlock: { return false })
        let child = createChildNode(val: output, geometry: box)
        toProcess.append(child)
        node.addChildNode(child)
	}
    
    private func createChildNode(val: Int?, geometry: SCNGeometry) -> SCNNode{
        let child = SCNNode(geometry: geometry)
        let value = (val != nil) ? String(val!) : " "
        child.name = "numberbox_" + self.name + "_" + value
        child.physicsBody = SCNPhysicsBody(type: .dynamic, shape:
            SCNPhysicsShape(geometry: geometry, options:  [SCNPhysicsShape.Option.scale: scale])
        )
        child.physicsBody!.isAffectedByGravity = true
        child.physicsBody!.categoryBitMask = 4
        child.physicsBody!.contactTestBitMask = 7
        child.physicsBody!.collisionBitMask = 7
        child.position = SCNVector3(x: -1.75, y: 2.5, z: 0)
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

