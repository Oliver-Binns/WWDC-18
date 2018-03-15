/*: Some Text
# Functions

A mathematical function takes an input and returns an output.

For example, we might have a function that adds two to a number.
*/
//#-hidden-code
import UIKit
import PlaygroundSupport

func addTwo(_ value: Int) -> Int{
	return value + 2
}
func double(_ value: Int) -> Int{
	return value * 2
}
//#-end-hidden-code
addTwo(0)
addTwo(1)
/*:
Or one that doubles it.
*/
double(2)
