public func multiply(_ a: Int, _ b: Int) -> Int{
	return a * b
}

public let addTwo = {
	(value: Int) -> Int in
	return value + 2
}
public let double = {
	(value: Int) -> Int in
	return value * 2
}

infix operator >>> : Compose
precedencegroup Compose { associativity: left }
public func >>> <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
	return { x in f(g(x)) }
}
