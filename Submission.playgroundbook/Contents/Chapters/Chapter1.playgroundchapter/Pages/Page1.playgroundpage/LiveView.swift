import UIKit
import SceneKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
let scene = FactoryScene()
PlaygroundPage.current.liveView = scene

let addTwoMachine = FunctionMachine(name: "+2", function: Math.addTwo)

scene.addMachine(addTwoMachine)
addTwoMachine.dropNumber(4)

let doubleMachine = FunctionMachine(name: "×2", function: Math.double)
