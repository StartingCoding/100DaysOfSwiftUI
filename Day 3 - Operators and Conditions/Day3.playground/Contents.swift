import Foundation

let firstInt = 5
let secondInt = 4

let add = firstInt + secondInt
let subtract = firstInt - secondInt
let multiply = firstInt * secondInt
let divide = firstInt / secondInt

let remainder = firstInt % secondInt

// Operator overloading means that you can use the same operator for different things
let sumOfIntegers = 42 + 42
let additionOfStrings = "First tring " + "second string"
let additionOfArrays = ["This", "is"] + ["an", "array"]

// Compound assignement operators are shorthand of operator and assignment operator
var score = 95
score -= 5
var quote = ""
quote += "This is a quote"

// Comparison operators allows us to compare different values
let firstName = "John"
let secondName = "Jack"
let firstNumber = 20
let secondNumber = 4

print(firstName == secondName)
print(firstName != secondName)
print(firstName < secondName)
print(firstName >= secondName)

print(firstNumber == secondNumber)
print(firstNumber != secondNumber)
print(firstNumber < secondNumber)
print(firstNumber >= secondNumber)

// Conditions
let number = 10
if number == 10 {
    print("This code will run if the condition is true")
} else if number < 10 {
    print("This code will run if the condition will evaluate to true")
} else {
    print("This code will run if the various conditions will evaluate to false")
}

// Combining conditions && ||
let five = 5
let four = 4
let total = 20

if five == 5 && four == 4 {
    print("This shoudl be 5 and 4")
}

if (five + four == total) || (five * four == total) {
    print("If five added to four is equal to 10, or five mulitplied by four is equal to 10, this code will run")
}

// Ternary operator (shorthand for if statement)
let condition = true
print(condition ? "This code will run if the condition is true" : "This code will run like the else statement")

// Switch statements
let isSwitchStatement = "Switch"
switch isSwitchStatement {
case "Switch":
    print("This is a switch statement")
case "If else":
    print("This is an if else statement")
case "Fallthrough":
    print("This block of code will run and also the block of code below it")
default:
    print("This code evaluates conditions")
}

// Range operators
let closedRange = 0...5             // Include last number
let halfOpenRange = 0..<5           // Exlude last number
let somePartialRange = ...3         // Goes from the start up to 3 included
