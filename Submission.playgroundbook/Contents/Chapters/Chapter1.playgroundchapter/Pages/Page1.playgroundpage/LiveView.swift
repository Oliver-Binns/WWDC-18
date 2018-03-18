import UIKit
import SceneKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
let scene = FactoryScene()
PlaygroundPage.current.liveView = scene

let addTwoMachine = FunctionMachine(name: "+2", function: addTwo)
//let doubleMachine = FunctionMachine("×2", double)
scene.addMachine(addTwoMachine)

