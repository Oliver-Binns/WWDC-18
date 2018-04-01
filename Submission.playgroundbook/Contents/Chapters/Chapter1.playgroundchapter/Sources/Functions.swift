import Foundation
import PlaygroundSupport

public let addTwo = {
    (value: Int) -> Int in
    return value + 2
}

public let double = {
    (value: Int) -> Int in
    return value * 2
}

public let addFour = addTwo >>> addTwo

public let multiply = {
    (a: Int, b: Int) -> Int in
    return a * b
}

public let squareRoot = {
    (value: Int) -> Int? in
    let ret = sqrt(Double(value))
    guard !ret.isNaN else { return nil }
    return Int(ret)
}

public let returnVal = {
    (value: Int) -> Int in
    return value
}

public var quadruple: (Int) -> Int = returnVal
public var doubleThenAddTwo: (Int) -> Int = returnVal
public var curriedMultiply = ~multiply

public func parse(_ text: String, notify machine: String, about function: String, _ f: (Int) -> Int?) -> Int?{
    let regex = "\(function)\\([^)]*"
    guard let range = text.range(of: regex, options: .regularExpression) else { return nil }
    let placeholder = String(text[range]).replacingOccurrences(of: "\(function)(", with: "")
    guard let digitRange = placeholder.range(of: "[-+]?[0-9]+", options: .regularExpression) else { return nil }
    guard let input = Int(placeholder[digitRange]) else { return nil }
    
    send(f: machine, input: input, output: f(input))
    
    return input
}

public func send(f: String, input: Int, output: Int?){
    var dict: [String: PlaygroundValue] = [
        "machine": .string(f),
        "arg" : .integer(input)
    ]
    if output != nil{
        dict["ret"] = .integer(output!)
    }
    
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

prefix operator ~
public prefix func ~<A, B, C>(f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}
