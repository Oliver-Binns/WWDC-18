/*:
# Domain and Range
## Domain
The domain is a set of all the values which we are allowed to input into our function.

Often there are some values that functions will not be able to process.
 
If a function cannot take every possible value, it is know as a **partial** function.


Your task here is to find input values which break the function machines.
*/

// squareRoot returns the square root of its input
// rounded to the nearest whole number.
//#-code-completion(everything, hide)
//#-code-completion(literal, show, integer)
squareRoot(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)
//#-hidden-code
import PlaygroundSupport

let input = parse(PlaygroundPage.current.text, notify: "√", about: "squareRoot", squareRoot)
if (input ?? 1) < 0 {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Congratulations, you've managed to break the function machines. It looks like you have a good understanding of partial functions!")
}
//#-end-hidden-code
/*:
## Range
The range is the set of the all values which our function may give as an output.
*/
