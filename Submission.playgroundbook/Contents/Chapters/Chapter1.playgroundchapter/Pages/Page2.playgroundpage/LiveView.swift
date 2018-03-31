import UIKit
import SceneKit
import PlaygroundSupport

let scene = FactoryScene()

let quadrupleMachine = FunctionMachine(name: "×4", function: Math.quadruple)
//quadrupleMachine.setInProgress(true)
scene.addMachine(quadrupleMachine)

let dtatMachine = FunctionMachine(name: "2n+2", function: Math.doubleThenAddTwo)
//dtatMachine.setInProgress(true)
scene.addMachine(dtatMachine)

PlaygroundPage.current.liveView = scene
