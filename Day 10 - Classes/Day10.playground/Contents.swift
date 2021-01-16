import Foundation

// MARK: Classes
class ThisIsAClass {
    var someProperty: String
    
    init(someProperty: String) {
        self.someProperty = someProperty
    }
}
let exmapleOfClass = ThisIsAClass(someProperty: "This is a string")

// MARK: Class Inheritance
class ParentClass { // Parent Class/Super Class
    var someProperty: String
    init(somePropertyFromClass: String) {
        someProperty = somePropertyFromClass
    }
}

class ChildClass: ParentClass { // Child Class/Sub Class
    init(somePropertyFromSubclass: String) {
        super.init(somePropertyFromClass: somePropertyFromSubclass)
    }
}
let exampleOfSuperClass = ParentClass(somePropertyFromClass: "This string is made from a superclass")
let exampleOfSubClass = ChildClass(somePropertyFromSubclass: "This string is made from a subclass")

// MARK: Override
class OriginalClass {
    func printAString() {
        print("This is a string from original class")
    }
}

class OverrideClass: OriginalClass {
    override func printAString() {
        print("This is a string from override class")
    }
}
let exampleOfOverrideClass = OverrideClass()
exampleOfOverrideClass.printAString()

// MARK: Final
class BaseClass { }
class SubClass: BaseClass { }
final class ThisClassCannotBeSubclassedOrModified: SubClass { }

// MARK: Copying Objects (Value Type/Reference Type)
class ObjectClass {
    var someProperty = "This is a string"
}
var istanceOfObjectClass = ObjectClass()
var firstPointer = istanceOfObjectClass
var secondPointer = istanceOfObjectClass
secondPointer.someProperty = "Changing this string here will change everywhere so every pointer to the ObjectClass has the same data"
var thirdPointer = istanceOfObjectClass
var fourthPointer = istanceOfObjectClass
print(secondPointer.someProperty) // classes = multiple instances have the same data
print(fourthPointer.someProperty) // structs = every istance of the struct holds their own data
print(firstPointer.someProperty)  //           instead of sharing it

// MARK: Deinitializers
class DeinitializedClass {
    var someProperty = "This is a string"
    
    init() { // Stuff to do when created
        print("Class created!")
    }
    
    deinit { // Stuff to do when deleted
        print("Class destroyed!")
    }
}
for _ in 1...3 {
    DeinitializedClass()
}

// MARK: Mutability
class VariableClass { var variableProperty = "can be changed" }
class ConstantClass { var variableProperty = "can be changed" }
struct VariableStruct { var variableProperty = "can be changed" }
struct ConstantStruct { var variableProperty = "cannot be changed" }

var exampleOfVariableClass = VariableClass()
exampleOfVariableClass.variableProperty = "This can be changed"
let exampleOfConstantClass = ConstantClass()
exampleOfConstantClass.variableProperty = "This can be changed"
var exampleOfVariableStruct = VariableStruct()
exampleOfVariableStruct.variableProperty = "This can be changed"
