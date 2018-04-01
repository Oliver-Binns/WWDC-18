/*:
# Mathematical Functions

A mathematical function takes an input and returns an output.

These functions work as machines to transform our input value into the desired output.

For example, we might have a function `addTwo` that increases the value of our input number by 2.

We can write this using algebra as:
 
 ![addTwo(x) = x + 2](addTwo.png)

 
Another function `double` multiplies its input number by 2.
 
 ![double(x) = 2x](double.png)
*/
// Try out each function with various inputs.
//#-code-completion(everything, hide)
//#-code-completion(literal, show, integer)
addTwo(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)
//#-hidden-code
import PlaygroundSupport
parse(PlaygroundPage.current.text, notify: "+2", about: "addTwo", addTwo)
//#-end-hidden-code
double(/*#-editable-code*/<#T##number##Int#>/*#-end-editable-code*/)
//#-hidden-code
parse(PlaygroundPage.current.text, notify: "×2", about: "double", double)
//#-end-hidden-code
