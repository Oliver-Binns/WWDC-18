/*:
# Currying

Currying is named after the American Mathematician, Haskell Curry.
 
![Haskell Curry](curry.jpg)
 
Currying transforms a function that takes lots of different inputs into a lot of functions that each take **one** input.
 
In Swift, this means the function ````multiply(x, y)```` becomes ````multiply(x)(y)````.
 
We can assume the a new operator (````~````) will allow us to curry functions.
 */
curriedMultiply = ~multiply

// Each input is now applied one at a time:
curriedMultiply(3)(4)
// Instead of all in one go:
multiply(3, 4)

/*:
 # Partial Application
 
We can use Currying to help us create new functions by using a technique called **partial application**.
 
With the new curried functions, we can apply each input at a time.
*/
//#-editable-code
let triple = curriedMultiply(3)
let six = triple(2) //returns 6
print(six)
//#-end-editable-code
