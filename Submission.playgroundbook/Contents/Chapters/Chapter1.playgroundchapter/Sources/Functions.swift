import Foundation

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
        (a: Int) -> Double in
        return sqrt(Double(a))
    }
    
    private static let returnVal = {
        (value: Int) -> Int in
        return value
    }
    
    public static var quadruple: (Int) -> Int = returnVal
    public static var doubleThenAddTwo: (Int) -> Int = returnVal
}

infix operator >>> : Compose
precedencegroup Compose {
    associativity: left
    higherThan: AdditionPrecedence
}
public func >>> <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
	return { x in f(g(x)) }
}
