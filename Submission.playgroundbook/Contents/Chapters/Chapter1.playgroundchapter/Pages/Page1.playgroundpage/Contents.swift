/*:
# Mathematical Functions

A mathematical function takes an input and returns an output.

These functions work as machines to transform our input value into the desired output.

For example, we might have a function `Math.addTwo` that increases the value of our input number by 2.

Or another function `Math.double` that multiplies the input number by 2.
*/
//#-code-completion(everything, hide)
Math.addTwo(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)
Math.double(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)
/*:
## Multiple Inputs
Some functions may take multiple inputs, but only one output is produced.
*/
Math.multiply(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/, /*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)

//#-hidden-code
import PlaygroundSupport
PlaygroundPage.current.assessmentStatus = .pass(message: "Well done, you've used the functions correctly!")
//#-end-hidden-code
