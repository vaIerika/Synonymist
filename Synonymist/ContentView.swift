//
//  ContentView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 12/04/2020.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var words = Words()
    
    @State private var correctVariant = Int.random(in: 0...3)
    @State private var score = 0
    @State private var questionNumber = 1
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var chosenVariant: Int?
    @State private var userAnswer: Bool?
    
    @State private var timer = Timer.publish(every: 0.3, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var timerCounter = 0
    
    static let numberOfQuestions = 5
    @State private var progress = Array(repeating: Question(), count: numberOfQuestions)
    
    @State private var showingHint = false
    
    @State private var showingScoreSheet = false
    @State private var mistakes: [Word] = []
    @State private var playedGames = 0
    @State private var wonGames = 0
    @State private var correctQuestionsInGame = 0
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
           
            VStack {

                
                VStack {
                    Text("QUESTION \(self.questionNumber) / 5")
                        .font(.custom("MavenPro-Bold", size: 13))
                        .foregroundColor(.ghostWhite)
                    
                    HStack {
                        ForEach(0..<progress.count, id: \.self) { i in
                            self.progress[i]
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 30)
                    
                    Text("Find a synonym for")
                        .font(.custom("MavenPro-Bold", size: 17))
                        .foregroundColor(.ghostWhite)
                    
                    HStack(spacing: 10) {
                        Text(words.collection[correctVariant].word.uppercased())
                            .font(.custom("MavenPro-Black", size: 21))
                            .foregroundColor(.ghostWhite)
                            .padding(.leading, 40)
                            
                        Button(action: {
                            self.showingHint = true
                        }) {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.turquoise)
                            
                        }
                        .frame(width: 30, height: 30)
                    }
                    Text(words.collection[correctVariant].meaning)
                        .font(.custom("MavenPro-SemiBold", size: 13))
                        .foregroundColor(.ghostWhite)
                        .lineLimit(2)
                        .padding(.horizontal)
                        .opacity(self.showingHint ? 1 : 0)
                }
                .padding(.top, 100)
                .padding(.bottom, 35)
                
                VStack(spacing: 30) {
                    ForEach(0..<4) { variant in
                        
                        Button(action: {
                            self.chosenVariant = variant
                            self.userAnswer = self.checkAnswer(variant: "\(self.words.collection[variant].synonyms[0])")
                            self.changeProgress()
                            self.timer = Timer.publish(every: 0.3, tolerance: 0.5, on: .main, in: .common).autoconnect()
                        }) {
                            if variant == self.chosenVariant {
                                VariantView(variant: "\(self.words.collection[variant].synonyms[0])", correct: self.userAnswer)
                            
                                    .onReceive(self.timer) { time in
                                        self.timerCounter += 1
                                        if self.timerCounter == 2 {
                                            self.nextQuestion()
                                            self.timer.upstream.connect().cancel()
                                    }
                                }
                            } else {
                                VariantView(variant: "\(self.words.collection[variant].synonyms[0])", correct: nil)
                            }
                        }
                        .disabled(self.userAnswer != nil)
                    }
                }
                .padding(.bottom,30)
                
                Spacer()
                Button(action: {
                    self.showingScoreSheet = true
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.turquoise)
                        Text("SCORE: \(score)")
                            .font(.custom("MavenPro-Bold", size: 13))
                    }
                    .foregroundColor(.ghostWhite)
                    .padding(.bottom, 70)
                }
                
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("Play more"), action: {
                    self.restartGame()
                }))
            }
            
            .sheet(isPresented: $showingScoreSheet) {
                ScoreView(score: self.score, mistakes: self.mistakes, playedGames: self.playedGames, wonGames: self.wonGames)
            }
        }
    }
    
    func checkAnswer(variant: String) -> Bool {
        if words.collection[correctVariant].synonyms.contains(variant) {
            if score < 9999 {
                score += 1
            }
            correctQuestionsInGame += 1
            return true
        } else {
            self.addMistakes()
            return false
        }
    }
    
    func countWonGames() {
        if correctQuestionsInGame == Self.numberOfQuestions {
            if wonGames < 51 {
                wonGames += 1
            }
        }
    }
    
    func addMistakes() {
        // 5 last unique mistakes only
        if mistakes.contains(words.collection[correctVariant]) {
           return
        }
        mistakes.insert(words.collection[correctVariant], at: 0)
        if mistakes.count > 5 {
            mistakes.remove(at: 5)
        }
    }
    
    func changeProgress() {
        if userAnswer != nil {
            if userAnswer == true {
                progress[questionNumber - 1].correct = true
            } else {
                progress[questionNumber - 1].correct = false
            }
        }
    }
        
    func nextQuestion() {
        chosenVariant = nil
        userAnswer = nil
        timerCounter = 0
        showingHint = false
        
        if questionNumber != Self.numberOfQuestions {
            questionNumber += 1
            randomiseWords()
            
        } else {
            if correctQuestionsInGame == 0 {
                alertTitle = "Ups! It was a quite hard game."
                alertMessage = "You haven't earned any points during this game. \nBut don't worry it will get better with practice."
            } else if correctQuestionsInGame < 5 {
                alertTitle = "Good work"
                alertMessage = "The more you practise the better you get! \n\(correctQuestionsInGame) points for this game."
            } else if correctQuestionsInGame < Self.numberOfQuestions {
                alertTitle = "Keep it up!"
                alertMessage = "You have increased your score for \(correctQuestionsInGame) points."
            } else if correctQuestionsInGame == Self.numberOfQuestions {
                alertTitle = "Impressive!"
                alertMessage = "You've answered all the questions correctly! \nYou have earned \(correctQuestionsInGame) points."
            }
            
            showingAlert = true
        }
    }
    
    func randomiseWords() {
        words.collection.shuffle()
        for word in words.collection {
            word.self.synonyms.shuffle()
        }
        correctVariant = Int.random(in: 0...3)
    }
    
    func restartGame() {
        countWonGames()
        playedGames += 1
        questionNumber = 1
        correctQuestionsInGame = 0
        progress = Array(repeating: Question(correct: nil), count: Self.numberOfQuestions)
        randomiseWords()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
