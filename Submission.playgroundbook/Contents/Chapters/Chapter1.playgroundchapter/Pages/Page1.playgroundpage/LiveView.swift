import UIKit
import SceneKit
import PlaygroundSupport

let scene = FactoryScene()
PlaygroundPage.current.liveView = scene

let addTwoMachine = FunctionMachine(name: "+2", function: Math.addTwo)
scene.addMachine(addTwoMachine)

let doubleMachine = FunctionMachine(name: "×2", function: Math.double)
scene.addMachine(doubleMachine)
