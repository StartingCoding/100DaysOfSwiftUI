//
//  ContentView.swift
//  TimesTables
//
//  Created by Loris on 13/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var tableSelection = 1
    @State private var numberOfQuestions = 5
    
    @State private var isAskingQuestions = false
    @State private var questionProgress = 0
    
    @State private var randomNumberForQuestion = Int.random(in: 1...12)
    @State private var randomGuesses = [Int]()
    
    var body: some View {
        Group {
            if isAskingQuestions == false {
                TimesTablesSettingsView(tableSelection: $tableSelection, numberOfQuestions: $numberOfQuestions, isAskingQuestions: $isAskingQuestions, randomNumberForQuestion: randomNumberForQuestion, randomGuesses: $randomGuesses, questionProgress: $questionProgress)
            } else {
                QuestionsView(randomGuesses: $randomGuesses, tableSelection: $tableSelection, questionProgress: $questionProgress, numberOfQuestions: $numberOfQuestions, randomNumberForQuestion: $randomNumberForQuestion, isAskingQuestions: $isAskingQuestions)
            }
        }
        .animation(.default)
    }
}

struct TimesTablesSettingsView: View {
    @Binding var tableSelection: Int
    @Binding var numberOfQuestions: Int
    @Binding var isAskingQuestions: Bool
    
    var randomNumberForQuestion: Int
    @Binding var randomGuesses: [Int]
    
    @Binding var questionProgress: Int
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color.purple, location: 0), Gradient.Stop(color: Color.white, location: 0.25), Gradient.Stop(color: Color.white, location: 0.7), Gradient.Stop(color: Color.blue, location: 1)]), startPoint: .top, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 120) {
                Text("TimesTables")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: Color(.displayP3, red: 0, green: 0, blue: 255, opacity: 0.35), radius: 8, x: 0, y: 4)
                
                Form {
                    Section(header: Text("Select table")) {
                        Stepper(value: $tableSelection, in: 1...12) {
                            Text("\(tableSelection)")
                        }
                    }
                    
                    Section(header: Text("How many questions?")) {
                        Stepper(value: $numberOfQuestions, in: 5...21, step: numberOfQuestions) {
                            if numberOfQuestions == 21 {
                                Text("All")
                            } else {
                                Text("\(numberOfQuestions)")
                            }
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Button(action: askQuestions) {
                        Text("Ask Questions!")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: Color(.displayP3, red: 255, green: 0, blue: 55, opacity: 0.3), radius: 5, x: 0.0, y: 3)
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .onAppear {
            tableSelection = 1
            numberOfQuestions = 5
            questionProgress = 0
            makeRandomGuesses()
        }
    }
    
    func askQuestions() {
        isAskingQuestions = true
        makeRandomGuesses()
    }
    
    func makeRandomGuesses() {
        var randomGuess: Int {
            let mid = tableSelection * randomNumberForQuestion
            let end = mid + tableSelection
            
            let startOfRange = mid - Int.random(in: 1...mid)
            let endOfRange = mid + Int.random(in: mid...end)
            
            return Int.random(in: startOfRange...endOfRange)
        }
        
        var randomIndex: Int {
            Int.random(in: 0...2)
        }
        
        var result = [Int]()
        
        for index in 0..<5 {
            if randomIndex == index {
                result.append(tableSelection * randomNumberForQuestion)
            } else {
                result.append(randomGuess)
            }
        }
        
        randomGuesses = result
    }
}

struct QuestionsView: View {
    @Binding var randomGuesses: [Int]
    @Binding var tableSelection: Int
    
    var question: String {
        "\(tableSelection)" + " x " + "\(randomNumberForQuestion)"
    }
    
    @Binding var questionProgress: Int
    @Binding var numberOfQuestions: Int
    
    @Binding var randomNumberForQuestion: Int
    @Binding var isAskingQuestions: Bool
    
    @State private var score = 0
    
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.white, Color.purple]), center: .center, startRadius: 5, endRadius: 300).edgesIgnoringSafeArea(.all)
            
            VStack {
                Divider()
                
                Text(question)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                ZStack {
                    Color.blue
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.blue)
                                .scaleEffect(animationAmount)
                                .opacity(Double(2 - animationAmount))
                                .animation(
                                    Animation.easeInOut(duration: 2)
                                        .repeatForever(autoreverses: false)
                                )
                        )
                        .padding()
                        .onAppear {
                            animationAmount = 2
                        }
                    
                    HStack(spacing: 10) {
                        ForEach(0..<5) { index in
                            Button(action: {tappedButton(index)}) {
                                Text("\(randomGuesses[index])")
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.yellow)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
                
                Divider()
                
                Text("\(questionProgress) / \(numberOfQuestions == 21 ? "All" : String(numberOfQuestions))")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title2)
                    .foregroundColor(.white)
                
                Divider()
            }
        }
    }
    
    func tappedButton(_ index: Int) {
        if randomGuesses[index] == tableSelection * randomNumberForQuestion {
            score += 10
        }
        
        generateQuestion()
    }
    
    func generateQuestion() {
        guard questionProgress != numberOfQuestions else { newGame(); return }
        
        questionProgress += 1
        randomNumberForQuestion = Int.random(in: 1...12)
        makeRandomGuesses()
    }
    
    func makeRandomGuesses() {
        var randomGuess: Int {
            let mid = tableSelection * randomNumberForQuestion
            let end = mid + tableSelection
            
            let startOfRange = mid - Int.random(in: 1...mid)
            let endOfRange = mid + Int.random(in: mid...end)
            
            return Int.random(in: startOfRange...endOfRange)
        }
        
        var randomIndex: Int {
            Int.random(in: 0...2)
        }
        
        var result = [Int]()
        
        for index in 0..<5 {
            if randomIndex == index {
                result.append(tableSelection * randomNumberForQuestion)
            } else {
                result.append(randomGuess)
            }
        }
        
        randomGuesses = result
    }
    
    func newGame() {
        isAskingQuestions = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
