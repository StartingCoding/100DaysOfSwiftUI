import Foundation

// MARK: For Loops
let arrayExample = ["This", "is", "an", "example", "for", "loops"]
for stringExample in arrayExample {
    print(stringExample)
}

// MARK: While Loops
var finish = 10
while finish <= 20 {
    print(finish)
    finish += 1
}

// MARK: Repeat Loop
var finishRepeatLoop: Int
repeat {
    finishRepeatLoop = 20
} while finishRepeatLoop < 20

// MARK: Exiting Loops
let arrayBreaking = ["This", "should", "stop", "here", "and", "not", "there"]
var indexArrayBreaking = 0
for stringBreak in arrayBreaking {
    if stringBreak == "here" {
        break
    }
    
    indexArrayBreaking += 1
}

print("We stop here on the index: \(indexArrayBreaking)")

// MARK: Exiting Multiple Loops
outerLoop: for i in 0...10 {
    for j in 0...10 {
        for k in 0...10 {
            if i == 5 && j == 5 && k == 5 {
                print("We find every five")
                break outerLoop
            }
        }
    }
}

// MARK: Skipping Items
for evenNumber in 0...10 {
    if evenNumber % 2 != 0 {
        continue
    }
    
    print("This will skip odd numbers and print even numbers like: \(evenNumber)")
}
