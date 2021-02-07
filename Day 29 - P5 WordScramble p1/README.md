# Day 29

Practiced with List, Bundle and String:
- Lists can generate dynamic rows from an array with an id pointing to something that makes the rows uniquely identifiable.
- The Bundle is one place to store all the files of yuor App (the binary code - the compiled version of your app) and you can use it to search for files to load with URLs. A main Bundle can have multiple Bundles inside like for iMessage app, WatchOS app, Siri extensions...
- You can crate arrays from strings using String.components(separatedBy:) and specifying what character it should split the string.
- You can delete whitespace and line breaks using String.trimmingCharacters(in: .whitespacesAndNewLines).
- You can check for misspells on strings using UITextChecker, but it uses some Objective-C stuff so you have to take the range of your Swift String with a NSRange(localtion: 0, lenght: swiftString.utf16.count) and the return value is also in Objective-C so if none misspell was found in this case it uses NSNotFound instead of the Swift Optional.

https://www.hackingwithswift.com/100/swiftui/29