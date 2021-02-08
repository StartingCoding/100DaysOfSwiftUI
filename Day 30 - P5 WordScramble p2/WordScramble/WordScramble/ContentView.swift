//
//  ContentView.swift
//  WordScramble
//
//  Created by Loris on 08/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord)
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
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        
        newWord = ""
    }
    
    func startGame() {
        if let filePath = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let contentOfFile = try? String(contentsOfFile: filePath.path) {
                let arrayOfWords = contentOfFile.components(separatedBy: "\n")
                
                rootWord = arrayOfWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("🔴 Failed to load start.txt from Bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
