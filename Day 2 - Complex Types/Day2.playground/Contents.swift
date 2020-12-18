import Foundation

let array = ["Arrays", "can", "hold", "multiple", "values", "and", "their", "index", "starts", "at", "0"]

let set = Set(["Sets", "are", "unordered", "collections", "of", "unique", "values"])

let tuple = (is: true, that: "this collection type", holds: 2, orMoreTypesOfItems: "but  after declared it cannot be changed anymore")
tuple.is

let dictionary = ["holds": "a", "key": "value", "pair": "."]
dictionary["key"]
dictionary["unordered", default: "true"]

enum EnumsHolds {
    case Specific(how: String)
    case Readable
    case Values
}
EnumsHolds.Specific(how: "We can describe a case so it can be much clean to read")
EnumsHolds.Values

enum HoldingValues: Int {
    case With
    case Specific
    case RawValues
}
let rawValues = HoldingValues(rawValue: 2)
