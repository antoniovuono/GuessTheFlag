//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Antonio Vuono on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnser = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var alertMessage = ""
    @State private var round = 0
    
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 10) {
                    Text("Guess the flag")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    
                    Text("Round \(round)")
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                VStack(spacing: 15) {
                    
                    if round == 0  {
                        Text("Start Guessing")
                            .foregroundStyle(.secondary)
                            .font(.title2.weight(.heavy))
                        
                        Button() {
                            round = 1
                        } label: {
                            Text("Start")
                                .padding()
                                .font(.subheadline.bold())
                                .foregroundStyle(.white)
                                .frame(maxWidth: 250)
                                .background(Color(red: 0.1, green: 0.2, blue: 0.45))
                                .clipShape(.capsule)
                                .padding(.horizontal)
                              
                        }
                        
                    }
                    
                    if round != 0 {
                        VStack {
                            Text("Tap the flag of")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            
                            Text(countries[correctAnser])
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .clipShape(.capsule)
                                    .shadow(radius: 1)
                            }
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
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(alertMessage)
        }
    }
    
    func flagTapped(_ number: Int ) {
        round += 1
        if number == correctAnser {
            scoreTitle = "Good job!"
            score += 10
            alertMessage = "Your score is \(score)"
        } else {
            print("Wrong!!!")
            scoreTitle = "Wrong!"
            alertMessage = "This flag belongs to \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnser = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
