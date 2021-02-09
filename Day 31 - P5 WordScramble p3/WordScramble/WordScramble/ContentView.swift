//
//  ContentView.swift
//  WordScramble
//
//  Created by Loris on 09/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Score: \(score)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button(action: startGame) {
                Text("New Game")
            })
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    func addNewWord() {
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            score -= 1
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            score -= 1
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            score -= 1
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        addPointsFor(answer)
        
        usedWords.insert(answer, at: 0)
        
        newWord = ""
    }
    
    func startGame() {
        if let filePath = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let contentOfFile = try? String(contentsOfFile: filePath.path) {
                let arrayOfWords = contentOfFile.components(separatedBy: "\n")
                
                rootWord = arrayOfWords.randomElement() ?? "silkworm"
                score = 0
                usedWords.removeAll(keepingCapacity: true)
                return
            }
        }
        
        fatalError("🔴 Failed to load start.txt from Bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var copyRootWord = rootWord
        
        for letter in word {
            if let index = copyRootWord.firstIndex(of: letter) {
                copyRootWord.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        guard (word.count <= 3) == false else { return false }
        guard (word == rootWord) == false else { return false }
        
        let checker = UITextChecker()
        let oldRangeOfWord = NSRange(location: 0, length: word.utf16.count)
        let rangeOfMisspelledWord = checker.rangeOfMisspelledWord(in: word, range: oldRangeOfWord, startingAt: 0, wrap: false, language: "en")
        
        return rangeOfMisspelledWord.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingError = true
    }
    
    func addPointsFor(_ word: String) {
        if word.count < 5 {
            score += 4
        } else if word.count < 6 {
            score += 6
        } else if word.count < 7 {
            score += 8
        } else {
            score += 20
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
            
    }
}
