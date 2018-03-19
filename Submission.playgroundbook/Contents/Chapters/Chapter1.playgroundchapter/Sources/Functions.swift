import Foundation

public let addTwo = {
	(value: Int) -> Int in
	return value + 2
}

public let double = {
	(value: Int) -> Int in
	return value * 2
}

public let multiply = {
	(a: Int, b: Int) -> Int in
	return a * b
}

public let squareRoot = {
	(a: Int) -> Double in
	return sqrt(Double(a))
}

infix operator >>> : Compose
precedencegroup Compose { associativity: left }
public func >>> <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
	return { x in f(g(x)) }
}
