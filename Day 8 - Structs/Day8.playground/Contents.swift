import Foundation

// MARK: Structs
struct ThisIsAStruct {
    var property: String
}
var instanceOfTheStruct = ThisIsAStruct(property: "some string")
print(instanceOfTheStruct.property)

// MARK: Computed Properties
struct ComputedProperties {
    var thisIsAStoredProperty: String
    
    var thisIsAComputedProperty: String {
        return "This is a computed property that could change its value and can be generated from mulitple things like: " + thisIsAStoredProperty
    }
}
let computedInstance = ComputedProperties(thisIsAStoredProperty: "This is a fixed value")
print(computedInstance.thisIsAStoredProperty)
print(computedInstance.thisIsAComputedProperty)

// MARK: Property Observers
struct ObserversProperties {
    var storedProperty: String
    var thisIsAPropertyObersver: String {
        didSet {
            print("\(thisIsAPropertyObersver): will be the new value")
        }
    }
}
var observerInstance = ObserversProperties(storedProperty: "This is stored", thisIsAPropertyObersver: "This will change")
print(observerInstance.thisIsAPropertyObersver)
observerInstance.thisIsAPropertyObersver = "change"

// MARK: Methods
struct Methods {
    var someValue = "This is some value"
    var otherValue = "That's aother value"
    var thirdValue = "This is the third value"
    
    func printingValues() {
        print("🖨 Ptinting Values of this struct from a method...")
        print("\(someValue)")
        print("\(otherValue)")
        print("\(thirdValue)")
    }
}
let exampleMethod = Methods()
exampleMethod.printingValues()

// MARK: Mutating Methods
struct MutatingMethods {
    var thisVlaueWillBeChangedIn = "Intial value"
    mutating func changeValue() {
        thisVlaueWillBeChangedIn = "Another value"
    }
}
var exampleMutatingMethods = MutatingMethods()
print("Before call to mutating func -> \(exampleMutatingMethods.thisVlaueWillBeChangedIn)")
exampleMutatingMethods.changeValue()
print("After call to mutating func -> \(exampleMutatingMethods.thisVlaueWillBeChangedIn)")

// MARK: Strings are Structs
let exampleString = "Strings are Structs"
print("This is a method of a struct (String) containing: \(exampleString.count) characters")

// MARK: Arrays are Structs
let exampleArray = ["Arrays", "are", "also", "Structs"]
print("This is a method of a struct (Array) containing: \(exampleArray.count) items")
