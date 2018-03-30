import UIKit
import SceneKit
import PlaygroundSupport

let scene = FactoryScene()

let quadrupleMachine = FunctionMachine(name: "×4", function: Math.quadrupleHidden)
//quadrupleMachine.setInProgress(true)
scene.addMachine(quadrupleMachine)

let dtatMachine = FunctionMachine(name: "2n+2", function: Math.dtatHidden)
//dtatMachine.setInProgress(true)
scene.addMachine(dtatMachine)

PlaygroundPage.current.liveView = scene
