/*:
# Currying & Partial Application

Currying is named after the American Mathematician, Haskell Curry.
*/
//#-hidden-code
func curry<A, B, C>(f: (A, B) -> C) -> A -> B -> C {
	return { a in { b in f(a, b) } }
}
//#-end-hidden-code
//#-editable-code
print("Hello World")
//#-end-editable-code
