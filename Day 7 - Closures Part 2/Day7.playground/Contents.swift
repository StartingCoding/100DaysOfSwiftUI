import Foundation

// MARK: Closures as Parameteres when accepting a Paramter
func funcThatTakesAClosureWithParameters(closureWithParamter: (String) -> Void) {
    closureWithParamter("this string that is the parameter of the closure")
}

funcThatTakesAClosureWithParameters { (parameter: String) in
    print("This code will print \(parameter)")
}

// MARK: Closures as Parameteres when accepting a Paramter and Return a value
func reduceUsingClosure(_ numbersToAdd: [Int], closureThatReduces: (Int, Int) -> Int) -> Int {
    print("I'm calculating...")
    var initial = numbersToAdd[0]
    
    for number in numbersToAdd[1...] {
        initial = closureThatReduces(initial, number)
    }
    
    return initial
}

let numbers = [10, 10, 20, 2]

let sum = reduceUsingClosure(numbers) { (initial: Int, nextNumber: Int) in
    initial + nextNumber
}
print(sum)

// MARK: Shorthand Parameter names
func funcForShorthand(closureShorthand: (String) -> String) {
    print("Printing something...")
    let message = closureShorthand("Printing something ")
    print(message)
}

funcForShorthand { (something: String) -> String in
    return something + "using classic syntax"
}

funcForShorthand { somethingShorter -> String in
    return somethingShorter + "using a shorter syntax"
}

funcForShorthand { somethingEvenShorter in
    return somethingEvenShorter + "using even a shorter one"
}

funcForShorthand { somethingEvenShorterThatThisParameterNameIsLonger in
    somethingEvenShorterThatThisParameterNameIsLonger + "using ridicolously shorter syntax"
}

funcForShorthand { $0 + "using tiny syntax" } // $0, $1, $3 are closure paramteres

// MARK: Returning Closures form Functions
func thisFuncReturnsAClosureThatReturnsString() -> () -> String {
    print("This code will run when the function is called")
    let closureInsideFucntion = { "This string is inside a closure that is inside a function so it will be run if the function is already being called." }
    return closureInsideFucntion
}

let functionCall = thisFuncReturnsAClosureThatReturnsString()
let closureCall = functionCall()
print(closureCall)

// MARK: Capturing Values
func capturingValues() -> () -> Void {
    var variableInFunction = "a string inside a function"
    
    return {
        print("If we want to use something out of this closure we can do it")
        print("We can use something like \(variableInFunction)")
        variableInFunction = "The value of this string is captured inside of the closure so we can keep it arond and modify it"
        print(variableInFunction)
    }
}

let capturingValueCall = capturingValues()
capturingValueCall()
