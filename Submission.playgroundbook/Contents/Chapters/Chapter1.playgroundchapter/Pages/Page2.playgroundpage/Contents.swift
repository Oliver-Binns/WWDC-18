/*:
# Function Composition

Often we will want to apply a function to the output of another function.

Imagine we want to double a number and add two


We may want to create a new function to join these two existing functions together.

We can assume a new function composition operation (````>>>````) will give us the ability to do this.


We can use this operation to easily create a new ````addFour```` function.
````
let addFour = addTwo >>> addTwo
addFour(2)
````


Your next task is to create two new functions:
* ````quadruple()````
* ````doubleThenAddTwo()````
*/
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, >>>, double, addTwo)
let quadruple = /*#-editable-code*/<#function composition#>/*#-end-editable-code*/ >>> /*#-editable-code*/<#function composition#>/*#-end-editable-code*/
//#-code-completion(everything, hide)
quadruple(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)

//#-code-completion(keyword, show, let)
//#-editable-code create doubleThenAddTwo
//#-end-editable-code
doubleThenAddTwo(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)
