import UIKit
import SceneKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

public class ThisScene: FactoryScene{
	let quadrupleMachine: FunctionMachine
	
	override init(){
		quadrupleMachine = FunctionMachine(name: "×4", function: Math.quadruple)
		super.init()
		
		//User needs to create some new functions:
		//Here we want to display two function machines which are a "work in progress"
		quadrupleMachine.setInProgress(true)
		self.addMachine(quadrupleMachine)
	}
	
	func update(){
		//When the user clicks "run code" and the function outputs the correct value
		//we can display fireworks and remove this "WIP" sign
		quadrupleMachine.setInProgress(false)
		
		//When both function machines are complete, the user can progress to the next page!
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

let scene = ThisScene()
PlaygroundPage.current.liveView = scene
