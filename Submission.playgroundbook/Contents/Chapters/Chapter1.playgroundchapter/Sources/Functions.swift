import Foundation
import PlaygroundSupport

public class Math{
    public static let addTwo = {
        (value: Int) -> Int in
        send(f: "+2", n: value)
        return value + 2
    }
    
    public static let double = {
        (value: Int) -> Int in
        send(f: "×2", n: value)
        return value * 2
    }
    
    public static let multiply = {
        (a: Int, b: Int) -> Int in
        send(f: "×", n: a)
        return a * b
    }
    
    public static let squareRoot = {
        (value: Int) -> Double in
        send(f: "√", n: value)
        return sqrt(Double(value))
    }
    
    private static let returnVal = {
        (value: Int) -> Int in
        return value
    }
    
    public static var quadruple: (Int) -> Int = returnVal
    public static var doubleThenAddTwo: (Int) -> Int = returnVal
}

public func send(f: String, n: Int){
    let dict: [String: PlaygroundValue] = [
        "machine": .string(f),
        "arg" : .integer(n)
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
