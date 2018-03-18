import SceneKit

public class FunctionMachine: SCNNode{
	var inProgress = false
	
	public init<A, B>(name: String, function: (A) -> B){
		super.init()
		
		let machine = SCNBox(width: 20, height: 20, length: 20, chamferRadius: 2)
		machine.firstMaterial?.transparency = 1
		machine.firstMaterial?.diffuse.contents = UIColor.red
		createChildNode(geometry: machine)
		
		let text = SCNText(string: name, extrusionDepth: 1)
		text.firstMaterial?.transparency = 1
		text.flatness = 0.2
		text.firstMaterial?.diffuse.contents = UIColor.black
		let (minVec, maxVec) = text.boundingBox
		createChildNode(x: (minVec.x - maxVec.x) / 2, y: minVec.y - maxVec.y, z: 20, geometry: text)
	}
	
	private func createChildNode(x : Float = 0, y: Float = 0, z: Float = 0, geometry: SCNGeometry){
		let node = SCNNode(geometry: geometry)
		node.position = SCNVector3(x: x, y: y, z: z)
		addChildNode(node)
	}
	
	public func setInProgress(){
		inProgress = true
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
