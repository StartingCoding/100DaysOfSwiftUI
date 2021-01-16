import Foundation

// MARK: Protocols
protocol ThisIsAProtocol {
    var thisIsTheRequirementToConformToThisProtocol: String { get set }
}

// MARK: Protocols Inheritance
protocol ThisIsOneProtocol {
    func getSomeString() -> String
}

protocol ThisIsAnotherProtocol {
    func getSomeBool() -> Bool
}

protocol ProtocolThatInhertiFromMultipleProtocols: ThisIsOneProtocol, ThisIsAnotherProtocol { }

// MARK: Extensions
extension String {
    var extensionOfString: String {
        return self + " from an extension"
    }
}
let exampleOfStringExtension = "This is a string"
print(exampleOfStringExtension.extensionOfString)

// MARK: Protocol Extension
extension CustomStringConvertible {
    var extensionForConvertingString: String {
        return "This is a string made by an extension of a protocol that is used by mulitple types\n\(self)"
    }
}
let exampleOfStringProtocolExtension = "This is a string"
let exampleOfArrayProtocolExtension = ["This", "is", "an", "array"]
print(exampleOfStringProtocolExtension.extensionForConvertingString)
print(exampleOfArrayProtocolExtension.extensionForConvertingString)
