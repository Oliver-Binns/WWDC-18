/*: Some Text
# Higher Order Functions

Some functions may take another function as one of their inputs.

These type of functions are known as Higher Order functions.
 
 Some commonly used higher order functions are:
 * ```map```
 * ```flatMap```
 * ```reduce```
*/
//#-hidden-code
func map(_ f: (Int) -> Int, _ list: [Int]) -> [Int]{
    list.map(f)
    return list
}
//#-end-hidden-code
//#-editable-code
// Map takes two inputs: a function and a list of values.
// It applies the function to each value in the list:
map(double, [1, 2, 3])
//#-end-editable-code
