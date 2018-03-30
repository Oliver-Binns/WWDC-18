import UIKit
import SceneKit
import PlaygroundSupport

let scene = FactoryScene()
let sqrtMachine = FunctionMachine(name: "√", function: Math.squareRoot)
scene.addMachine(sqrtMachine)

PlaygroundPage.current.liveView = scene
//sqrtMachine.destroy()
