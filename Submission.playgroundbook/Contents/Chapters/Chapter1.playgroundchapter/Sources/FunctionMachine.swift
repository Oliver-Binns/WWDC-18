import SceneKit

public class FunctionMachine: SCNNode{
	var workInProgress = false
	
	public init<A, B>(name: String, function: (A) -> B){
		super.init()
		
		let width: CGFloat = 60
		let height: CGFloat = 40
		let length: CGFloat = 20
		
		let machineColor = UIColor(red: 28/255.0, green: 117/255.0, blue: 188/255.0, alpha: 1)
		
		let machine = SCNBox(width: width, height: height, length: length, chamferRadius: 2)
		machine.firstMaterial?.transparency = 1
		machine.firstMaterial?.diffuse.contents = machineColor
		createChildNode(geometry: machine)
		
		let io = SCNBox(width: width / 3, height: height / 3, length: length - 1, chamferRadius: 1)
		io.firstMaterial?.transparency = 1
		io.firstMaterial?.diffuse.contents = UIColor.darkGray
		createChildNode(x: Float(-width / 2), y: -Float(height / 5), geometry: io)
		createChildNode(x: Float(width / 2), y: -Float(height / 5), geometry: io)
		
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
	
	public func destroy(){
		
	}
	
	public func setInProgress(_ value: Bool){
		workInProgress = value
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
