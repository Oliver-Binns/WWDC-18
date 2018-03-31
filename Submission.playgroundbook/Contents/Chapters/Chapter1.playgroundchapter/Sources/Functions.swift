import Foundation
import PlaygroundSupport

public class Math{
    public static let addTwo = {
        (value: Int) -> Int in
        return value + 2
    }
    
    public static let double = {
        (value: Int) -> Int in
        return value * 2
    }
    
    public static let multiply = {
        (a: Int, b: Int) -> Int in
        return a * b
    }
    
    public static let squareRoot = {
        (value: Int) -> Int? in
        let ret = sqrt(Double(value))
        guard !ret.isNaN else { return nil }
        return Int(ret)
    }
    
    private static let returnVal = {
        (value: Int) -> Int in
        return value
    }
    
    public static var quadruple: (Int) -> Int = returnVal
    public static var doubleThenAddTwo: (Int) -> Int = returnVal
}

public func parse(_ text: String, notify machine: String, about function: String, _ f: (Int) -> Int?){
    let regex = "\(function)\\([^)]*"
    guard let range = text.range(of: regex, options: .regularExpression) else { return }
    let placeholder = String(text[range]).replacingOccurrences(of: "\(function)(", with: "")
    guard let digitRange = placeholder.range(of: "[0-9]+", options: .regularExpression) else { return }
    guard let input = Int(placeholder[digitRange]) else { return }
    send(f: machine, input: input, output: f(input))
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
