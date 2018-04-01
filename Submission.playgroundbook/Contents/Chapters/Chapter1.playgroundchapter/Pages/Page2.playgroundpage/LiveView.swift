import UIKit
import SceneKit
import PlaygroundSupport

let scene = FactoryScene()

let addFourMachine = FunctionMachine(name: "+4", function: addFour)
scene.addMachine(addFourMachine)

let quadrupleMachine = FunctionMachine(name: "×4", function: quadruple)
quadrupleMachine.setInProgress(true)
scene.addMachine(quadrupleMachine)

let dtatMachine = FunctionMachine(name: "2n+2", function: doubleThenAddTwo)
dtatMachine.setInProgress(true)
scene.addMachine(dtatMachine)

PlaygroundPage.current.liveView = scene
