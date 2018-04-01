/*:
# Currying & Partial Application


Currying is named after the American Mathematician, Haskell Curry.
 
![Haskell Curry](curry.jpg)
 

In Swift, this means the function ````multiply(x, y)```` becomes ````multiply(x)(y)````.
We can assume the a new operator (````~````) will allow us to curry functions.
 */
//#-hidden-code
prefix operator ~
prefix func ~<A, B, C>(f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
	return { a in { b in f(a, b) } }
}
//#-end-hidden-code
//#-editable-code
let multiply = ~multiply
multiply(3)(4)
//#-end-editable-code
/*:
We can use Currying to help us create new functions by using a technique called partial application.
 
With the new curried functions, we can apply each argument separately.
````
triple = multiply(3)
triple(2) //returns 6
````
*/
let double = multiply(2)
double(4)
