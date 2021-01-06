import Foundation

// Initializer
struct StructWithDefaultMemberwiseInitializer {
    var someProperty = "Some string"
}
let exampleOfStructWithDefaultMemberwiseInitializer = StructWithDefaultMemberwiseInitializer()

struct StructWithCustomInitializer {
    var someProperty = "Some string"
    
    init() {
        someProperty = "Another string"
        print("This init will replace the default memberwise init")
    }
}
let exampleOfStructWithCustomInitializer = StructWithCustomInitializer()

// Lazy Properties
struct StructWithLazy {
    lazy var someLazyProperty = "This string will be created only when accessed"
}
var exmapleOfStructWithLazy = StructWithLazy()
print("\(exmapleOfStructWithLazy.someLazyProperty)")

// Static Properties and Methods
struct StaticStruct {
    static var count = 0
    
    init() {
        StaticStruct.count += 1
    }
}
let exampleOfStaticStructOne = StaticStruct()
let exampleOfStaticStructTwo = StaticStruct()
let exampleOfStaticStructThree = StaticStruct()
let exampleOfStaticStructFour = StaticStruct()
let exampleOfStaticStructFive = StaticStruct()
print("Static property will get assigned to type itself and not on the instance of the struct so making multiple instance of the same struct type like this it will call the init and make the count go up to \(StaticStruct.count)")

// Access Control
struct StructWithAccessControl {
    private var thisPropertyIsPrivate = "Some private value"
    
    func getPrivateProperty() -> String {
        return "This is the private property: -> \(thisPropertyIsPrivate)"
    }
}
let exampleOfStructWithAccessControl = StructWithAccessControl()
let privateProperty = exampleOfStructWithAccessControl.getPrivateProperty()
print(privateProperty)
