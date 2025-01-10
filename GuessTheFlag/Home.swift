//
//  Home.swift
//  GuessTheFlag
//
//  Created by Antonio Vuono on 08/01/25.
//

import SwiftUI

struct Home: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var round = 1
    @State private var showAlert = false
    @State private var scoreAlertTitle: String = ""
    @State private var scoreAlertMessage: String = ""
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                       .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                       .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            Spacer()
            
            VStack {
                VStack(spacing: 10) {
                    Text("Guess the flag")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    
                    Text("Round \(round)")
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    
                    Text("\(countries[correctAnswer])")
                        .font(.largeTitle.weight(.semibold))
                    
                    ForEach(0..<3) { country in
                        Button {
                            flagTapped(country)
                        } label: {
                            Image(countries[country])
                                .clipShape(.capsule)
                                .shadow(radius: 1)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreAlertTitle, isPresented: $showAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreAlertMessage)
        }
    }
    
    func flagTapped(_ number: Int) {
        round += 1
        
        if number == correctAnswer {
            score += 10
            showAlert = true
            scoreAlertTitle = "Correct!"
            scoreAlertMessage = "You score is \(score)"
            
        } else {
            showAlert =  true
            scoreAlertTitle = "Wrong!"
            scoreAlertMessage = "This flag belong \(countries[number])"
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        resetGame()
    }
    
    func resetGame() {
        if round >= 8 {
            round = 0
            score = 0
        }
    }
}

#Preview {
    Home()
}
