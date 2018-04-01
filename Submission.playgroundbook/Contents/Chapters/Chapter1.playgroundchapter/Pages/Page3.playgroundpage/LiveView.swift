import UIKit
import SceneKit
import PlaygroundSupport

let scene = ARFactoryScene()

let sqrtMachine = FunctionMachine(name: "√", function: squareRoot)
scene.addMachine(sqrtMachine)

PlaygroundPage.current.liveView = scene.getView()
