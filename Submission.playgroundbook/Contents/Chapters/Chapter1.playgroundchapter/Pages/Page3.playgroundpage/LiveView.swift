import UIKit
import SceneKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

public class ThisScene: FactoryScene{
	var sqrt: (Int) -> Int = {
		value in
		return value
	}
	let sqrtMachine: FunctionMachine
	
	override init(){
		sqrtMachine = FunctionMachine(name: "√", function: sqrt)
		super.init()
	
		self.addMachine(sqrtMachine)
	}
	
	func update(){
		//The user's task is to explore the domain and range of partial functions
		//The function machine should smoke and break down attempting to compute the values of certain types
		sqrtMachine.destroy()
		
		//When both function machines are destroyed, the user can progress to the next page!
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

let scene = ThisScene()
PlaygroundPage.current.liveView = scene
