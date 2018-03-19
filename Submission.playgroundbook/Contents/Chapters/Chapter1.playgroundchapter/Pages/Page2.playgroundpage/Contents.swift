/*:
# Function Composition

Often we will want to apply a function to the output of another function.

Imagine we want to double a number and add two


We may want to create a new function to join these two existing functions together.

We can assume a new function composition operation (````>>>````) will give us the ability to do this.

Functions can now be combined, but remember the function on the right-hand side will be applied first.


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

//#-hidden-code
import PlaygroundSupport

var quadPass = true
var dTATPass = true
for i in [0..<4]{
	quadPass = quadPass && quadruple(i) == i * 4
	dTATPass = dTATPass && doubleThenAddTwo(i) == (i * 2) + 2
}
if(quadPass && dTATPass){
	PlaygroundPage.current.assessmentStatus = .pass(message: "Congratulations, your new functions work correctly!")
}else{
	var hints: [String] = []
	if(!quadPass){
		hints.append("Looks like your quadruple function doesn't work! Try applying double to double.")
	}else if(!dTATPass){
		hints.append("Remember, the function on the right is applied first.")
	}
	PlaygroundPage.current.assessmentStatus = .fail(hints: hints, solution: nil)
}

//#-end-hidden-code
