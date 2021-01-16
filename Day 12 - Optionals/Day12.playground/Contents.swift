import Foundation

// MARK: Otionals
var str: String? = "Hello, playground"

// MARK: Unwrapping Optionals - if let
if let unwrappedString = str {
    print("The string exists and has a value of \(unwrappedString)")
} else {
    print("The string doesn't exists yet")
}

// MARK: Unwrapping Optionals - guard let
func someFuncCheckingForOptionals(someOptionalString: String?) {
    guard let unwrappedSomeOptionalString = someOptionalString else { return }
    // The variable unwrapped can be used outside the guard statement
    print(unwrappedSomeOptionalString)
}
let exampleOfGuardLet = "Some string"
someFuncCheckingForOptionals(someOptionalString: exampleOfGuardLet)

// MARK: Force Unwrapping
let absolutelySafeToUnwrapBecauseIHandTypedIt = "42"
let intNonOptional = Int(absolutelySafeToUnwrapBecauseIHandTypedIt)!
// This is Int because we use the force
// uwrapp "!" otherwise is Optional(Int)
print(type(of: intNonOptional))

// MARK: Implicitly Unwrapped Optionals
let implicitlyUnwrappedOptional: String! = "something"
let exampleOfUsingIUOs: String = implicitlyUnwrappedOptional
// The optional is still Optional(String) but we can we can use it without unwrapping.
// Generally used in class initialization when we know something initially doesn't have a value
// but when we used it we expect to always have it.
// Make sure when you're using one it's not nil because it will crash
print(exampleOfUsingIUOs)

// MARK: Nil Coalescing
let optionaltoUnwrapUsingNilCoalescing: String? = nil
let exampleOfNilCoalescing = optionaltoUnwrapUsingNilCoalescing ?? "Deafult value if the optional is nil"
print(type(of: exampleOfNilCoalescing))     // Nil coalescing doesn't return an Optional

// MARK: Optional Chaining
let optionalChaining: String? = nil
let exampleOfOptionalChaining = optionalChaining?.last?.uppercased()
// if an optional is nil the chain stops and return nil
// else continues and returns the optional
let otherExampleOfOptionalChaining = optionalChaining?.uppercased() ?? "NIL"

// MARK: Optional Try
func canThrow() throws -> String {
    return "This is a string"
}

do {
    try canThrow()                          // Using try/catch you can be specific about the kind
} catch {                                   // of error and how to deal with it
    // Catch the error
}

if let resultOfTry = try? canThrow() {      // Using otpional try will return the result of the func
    print(resultOfTry)                      // or nil
} else {
    print("The result of the call was nil")
}

try! canThrow()                             // Use when you know it doesn't throw an error,
                                            // if the func throw like this it will crash

// MARK: Failable Initializers
struct SomeFailableStruct {
    var someProperty: String
    
    init?(someProperty: String) {
        if someProperty == "This will fail" {
            return nil
        } else {
            self.someProperty = someProperty
        }
    }
}
let exampleOfSomeFailableStruct = SomeFailableStruct(someProperty: "This will fail")
let anotherExampleOfSomeFailableStruct = SomeFailableStruct(someProperty: "This will not fail")

// MARK: Typecasting
class SuperClass { }
class SubClassOne: SuperClass { }
class SubClassTwo: SuperClass { }
let exampleOfSubClassOne = SubClassOne()
let exampleOfSubClassTwo = SubClassTwo()
let exampleArray = [exampleOfSubClassOne, exampleOfSubClassTwo]

for subClass in exampleArray {
    if let superClass = subClass as? SuperClass {
        print("subClass instance of SubClass can be type casted to SuperClass")
    }
}
