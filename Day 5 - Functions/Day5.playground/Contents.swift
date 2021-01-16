import Foundation

// MARK: Functions
func thisIsAFunction() {
    let some = "textToPrint"
    print(some)
}
thisIsAFunction()

// MARK: Parameters
func thisFuncAccept(parameter: String) {
    print("The parameter of this function is: \(parameter)")
}
thisFuncAccept(parameter: "a cool string")

// MARK: Returning value
func thisFuncReturnsA(valueOfType: String) -> String {
    return "This function return a: \(valueOfType)"
}
thisFuncReturnsA(valueOfType: "String")

// MARK: Parameter Label
func thisFuncUsesParameterLabelLike(outsideOfFunction insideOfFunction: String) {
    print("Inside the function we're using: \(insideOfFunction)")
}
thisFuncUsesParameterLabelLike(outsideOfFunction: "this string")

// MARK: Omitting parameters
func thisFuncOmitsParamatersLike(_ this: String) {
    print("Inside this function we're using: \(this)")
}
thisFuncOmitsParamatersLike("this string")

// MARK: Default parameter
func youCanMakeDefaultParameter(like: String = "like this") {
    print(like)
}
youCanMakeDefaultParameter()
youCanMakeDefaultParameter(like: "or changing after if you want like that")

// MARK: Variadic Function
func thisFunctionAccepts(_ variadic: String...) {
    for element in variadic {
        print("The value passed to this funuction is: \(element)")
    }
}
thisFunctionAccepts("this value", "that value", "and", "so", "on")

// MARK: Writing throwing function
enum ContainingErrors: Error {
    case thisIsAnErrorCase
}

func thisFunctionCanThrowAnError(yesOrNo: Bool) throws -> Bool {
    if yesOrNo == true {
        throw ContainingErrors.thisIsAnErrorCase
    }
    
    return true
}

do {
    try thisFunctionCanThrowAnError(yesOrNo: true)
    print("This code will run if the function above doesn't throw errors")
} catch {
    print("this code will run if some errors happend")
}

// MARK: inout parameters
func thisFunctionChangesValueInPlace(addingTwoToTheValueToChange number: inout Int) {
    number += 2
}

var numberStartingToZero = 0
thisFunctionChangesValueInPlace(addingTwoToTheValueToChange: &numberStartingToZero)
thisFunctionChangesValueInPlace(addingTwoToTheValueToChange: &numberStartingToZero)
thisFunctionChangesValueInPlace(addingTwoToTheValueToChange: &numberStartingToZero)
