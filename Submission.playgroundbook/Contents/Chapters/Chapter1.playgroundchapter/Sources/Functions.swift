import Foundation
import PlaygroundSupport

public class Math{
    public static let addTwo = {
        (value: Int) -> Int in
        send(f: "+2", input: value, output: value + 2)
        return value + 2
    }
    
    public static let double = {
        (value: Int) -> Int in
        send(f: "×2", input: value, output: value * 2)
        return value * 2
    }
    
    public static let multiply = {
        (a: Int, b: Int) -> Int in
        send(f: "×", input: a, output: a * b)
        return a * b
    }
    
    public static let squareRoot = {
        (value: Int) -> Int in
        let ret = Int(sqrt(Double(value)))
        send(f: "√", input: value, output: ret)
        return ret
    }
    
    private static let returnVal = {
        (value: Int) -> Int in
        return value
    }
    
    public static var quadruple: (Int) -> Int = returnVal
    public static var doubleThenAddTwo: (Int) -> Int = returnVal
    
    public static let quadrupleHidden = {
        (value: Int) -> Int in
        let ret = quadruple(value)
        send(f: "×4", input: value, output: ret)
        return ret
    }
    public static let dtatHidden = {
        (value: Int) -> Int in
        let ret = doubleThenAddTwo(value)
        send(f: "2n+2", input: value, output: ret)
        return ret
    }
}

public func send(f: String, input: Int, output: Int){
    let dict: [String: PlaygroundValue] = [
        "machine": .string(f),
        "arg" : .integer(input),
        "ret": .integer(output)
    ]
    
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(.dictionary(dict))
    }
}

infix operator >>> : Compose
precedencegroup Compose {
    associativity: left
    higherThan: AdditionPrecedence
}
public func >>> <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
	return { x in f(g(x)) }
}
