import UIKit
import SceneKit
import PlaygroundSupport

let scene = ARFactoryScene()

let addTwoMachine = FunctionMachine(name: "+2", function: addTwo)
scene.addMachine(addTwoMachine)

let doubleMachine = FunctionMachine(name: "×2", function: double)
scene.addMachine(doubleMachine)

PlaygroundPage.current.liveView = scene.getView()
