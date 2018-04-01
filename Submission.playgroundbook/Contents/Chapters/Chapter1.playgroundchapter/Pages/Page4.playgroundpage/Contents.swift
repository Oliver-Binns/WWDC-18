/*:
# Currying & Partial Application


Currying is named after the American Mathematician, Haskell Curry.
 
![Haskell Curry](curry.jpg)
 

In Swift, this means the function ````multiply(x, y)```` becomes ````multiply(x)(y)````.
We can assume the a new operator (````~````) will allow us to curry functions.
 */
curriedMultiply = ~multiply
curriedMultiply(3)(4)
/*:
We can use Currying to help us create new functions by using a technique called partial application.
 
With the new curried functions, we can apply each argument separately.
*/
//#-editable-code
var triple = curriedMultiply(3)
triple(2) //returns 6
//#-end-editable-code
