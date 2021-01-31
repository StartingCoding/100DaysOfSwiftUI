//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Loris on 31/01/21.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👊", "✋", "✌️"]
    @State private var randomEmoji = Int.random(in: 0...2)
    @State private var score = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color.black, location: 0.27), Gradient.Stop(color: Color.white, location: 0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                Divider()
                
                BigTitles(score: score)
                
                Spacer()
                
                Text("\(emojis[randomEmoji])")
                    .font(.system(size: 150))
                    .shadow(color: .black, radius: 2)
                
                Spacer()
                
                GameControls(score: $score, emojis: emojis, randomEmoji: $randomEmoji)
                
                Divider()
            }
        }
    }
}

struct BigTitles: View {
    var score: Int
    
    var body: some View {
        VStack {
            Text("Rock Paper Scissors")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            Text("Score: \(score)")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}

struct GameControls: View {
    @Binding var score: Int
    let emojis: [String]
    @Binding var randomEmoji: Int
    
    var rock: String {
        emojis[0]
    }
    var paper: String {
        emojis[1]
    }
    var scissors: String {
        emojis[2]
    }
    
    let challenges = ["Win", "Lose", "Draw"]
    var randomChallenge = Int.random(in: 0...2)
    var challengeColor: Color {
        if randomChallenge == 0 {
            return Color.green
        } else if randomChallenge == 1 {
            return Color.red
        } else {
            return Color.yellow
        }
    }
    
    @State private var isShowing = false
    var alertMessages = ["Yep! That's 100% a Draw!",
                         "Yeah.. you know you should Win sometimes right?",
                         "Yeah.. I know.. I know.. but Loosing is not that bad..",
                         "You Win! Fantastic!",
                         "You Win.. but you gotta Lose sometime!",
                         "You Win.. why don't we make it a Draw next time!",
                         "You Lose! Good Job!",
                         "You Lose.. you have to Win sometimes!",
                         "You Lose.. you should try a Draw next time!"]
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 120, height: 50)
                    .foregroundColor(challengeColor)
                    .shadow(color: Color(.displayP3, red: 0.0, green: 0.0, blue: 0.0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                
                Text(challenges[randomChallenge])
                    .foregroundColor(randomChallenge == 2 ? .black : .white)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
            }
            HStack(spacing: 30) {
                Text(rock)
                    .font(.system(size: 60))
                    .shadow(color: .gray, radius: 5)
                    .onTapGesture {
                        choosing(0)
                        isShowing.toggle()
                    }
                Text(paper)
                    .font(.system(size: 60))
                    .shadow(color: .gray, radius: 5)
                    .onTapGesture {
                        choosing(1)
                        isShowing.toggle()
                    }
                Text(scissors)
                    .font(.system(size: 60))
                    .shadow(color: .gray, radius: 5)
                    .onTapGesture {
                        choosing(2)
                        isShowing.toggle()
                    }
            }
            .alert(isPresented: $isShowing, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                    randomEmoji = Int.random(in: 0...2)
                })
            })
        }
        .padding()
    }
    
    func choosing(_ emojiChosen: Int) {
        // If the chosenEmoji is above 1 position in the array from the randomEmoji -> Win
        // If the chosenEmoji is below 1 position in the array from the randomEmoji -> Lose
        // So if the chosenEmoji is the first or the last one in the array
        // we can't go back 1 position to win and if we are last in the array we can't go up 1 position to lose
        // We need to handle this particular cases "wrapping" the array
        // so the first emojy can win only if we add to it all the positions of the array til the last one and Win
        // and the last emoji can lose only if we add to the randomEmojy all the positions of the array til the last one and Lose
        if (randomEmoji == emojiChosen - 1) || (randomEmoji == emojiChosen + (emojis.count - 1)) {
            alertTitle = "Win"
            if randomChallenge == 0 {
                alertMessage = alertMessages[3]
                score += 1
            } else if randomChallenge == 1 {
                alertMessage = alertMessages[4]
                score -= 1
            } else {
                alertMessage = alertMessages[5]
            }
        } else if (randomEmoji == emojiChosen + 1) || (emojiChosen == randomEmoji + (emojis.count - 1)) {
            alertTitle = "Lose"
            if randomChallenge == 1 {
                alertMessage = alertMessages[6]
                score += 1
            } else if randomChallenge == 0 {
                alertMessage = alertMessages[7]
                score -= 1
            } else {
                alertMessage = alertMessages[8]
            }
        } else {
            alertTitle = "Draw"
            if randomChallenge == 2 {
                alertMessage = alertMessages[0]
                score += 1
            } else if randomChallenge == 0 {
                alertMessage = alertMessages[1]
                score -= 1
            } else {
                alertMessage = alertMessages[2]
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
