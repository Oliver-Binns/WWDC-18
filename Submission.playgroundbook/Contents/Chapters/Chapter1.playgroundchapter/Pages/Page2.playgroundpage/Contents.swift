/*:
# Function Composition

Often we will want to apply a function to the output of another function.

Imagine we want to double a number and add two


We may want to create a new function to join these two existing functions together.

We can assume a new function composition operation (````>>>````) will give us the ability to do this.

Functions can now be combined, but remember the function on the **right-hand** side will be applied first.


We can use this operation to easily create a new ````addFour```` function.
````
addFour = addTwo >>> addTwo
addFour(2)
````


Your next task is to build some new functions using function composition.
*/
//#-code-completion(everything, hide)
//#-code-completion(literal, show, integer)
addFour(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)

//#-hidden-code
import PlaygroundSupport
parse(PlaygroundPage.current.text, notify: "+4", about: "addFour", addFour)
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, addTwo, addFour, double, quadruple)
// Your new function should multiply its input by 4.
quadruple = /*#-editable-code*/<#first function#>/*#-end-editable-code*/ >>> /*#-editable-code*/<#second function#>/*#-end-editable-code*/
//#-code-completion(everything, hide)
//#-code-completion(literal, show, integer)
quadruple(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)

//#-hidden-code
parse(PlaygroundPage.current.text, notify: "×4", about: "quadruple", quadruple)

var quadPass = true
for i in 0...4{
    quadPass = quadPass && quadruple(i) == i * 4
}
if(quadPass){
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Remember, the function on the right is applied first."], solution: nil)
}else{
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["To quadruple a function, try doubling it twice!"], solution: nil)
}
//#-end-hidden-code

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, addTwo, addFour, double, quadruple)
// This function is fairly self-explanatory.
// If you enter 3, it should output (3×2)+2 = 8
doubleThenAddTwo = /*#-editable-code*/<#compose your function#>/*#-end-editable-code*/
//#-code-completion(everything, hide)
//#-code-completion(literal, show, integer)
doubleThenAddTwo(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)

//#-hidden-code
parse(PlaygroundPage.current.text, notify: "2n+2", about: "doubleThenAddTwo", doubleThenAddTwo)
var dTATPass = true
for i in 0...4{
	dTATPass = dTATPass && doubleThenAddTwo(i) == (i * 2) + 2
}
if(!dTATPass){
    PlaygroundPage.current.assessmentStatus = .fail(hints: ["Remember, the function on the right is applied first."], solution: nil)
}else{
    PlaygroundPage.current.assessmentStatus = .pass(message: "Congratulations, your new functions work correctly!")
}
//#-end-hidden-code
