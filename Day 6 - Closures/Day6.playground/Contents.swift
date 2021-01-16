import Foundation

// MARK: Basic Closure
let closure = {
    print("This is a closure stores in a variable")
}
closure()

// MARK: Accepting Parameters in closures
let closureAcceptingParamter = { (parameter: String) in
    print("This closure accept this \(parameter)")
}
closureAcceptingParamter("string parameter")

// MARK: Returning values from a closure
let closureReturningValue = { (something: String) -> String in
    return "This closure return this string with this paramater -> " + something
}
let message = closureReturningValue("This is a string")
print(message)

// MARK: Closure as paramter
let closureParameter = {
    print("This code runs from a closure")
}

func printDifferentStrings(printSomethingFrom: () -> Void) {
    print("This code runs inside a function")
    printSomethingFrom()
    print("This code runs inside a function but after a closure")
}

printDifferentStrings(printSomethingFrom: closureParameter)

// MARK: Trailing closure
func thisFuncTakesAClosureToTheEnd(trailingClosure: () -> Void) {
    print("This function will print this string and run whatever closure is passed by")
    trailingClosure()
}

thisFuncTakesAClosureToTheEnd {
    print("like this")
}

thisFuncTakesAClosureToTheEnd {
    print("like that")
}

thisFuncTakesAClosureToTheEnd(trailingClosure: {
    print("You can call this function even like this but it could be less readable")
})
