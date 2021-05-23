//
//  ContentView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 12/04/2020.
//

import SwiftUI

struct ContentView: View {
    let game: Game
    @ObservedObject var userStatus: UserStatus
    
    @State private var wordsForRound: [Word]
    @State private var showUserStatus = false
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    init(game: Game, userStatus: UserStatus) {
        self.game = game
        self.userStatus = userStatus
        _wordsForRound = State(initialValue: game.getWordsForRound())
    }
    
    private var BackgroundImage: some View {
        Image("background")
            .resizable()
            .scaledToFill()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            BackgroundImage
            
            GameView(game: game, wordsForRound: wordsForRound) { correctAnswers, mistakes in
                userStatus.finishGame(correctAnswers: correctAnswers, mistakes: mistakes)
                showAlert(with: correctAnswers)
            }
            ScoreView(score: userStatus.score, showUserStatus: $showUserStatus)
        }
        .edgesIgnoringSafeArea(.all)
        
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("Play more"), action: {
                    startNewRound()
                })
            )
        }
        .sheet(isPresented: $showUserStatus) {
            UserStatusView(score: userStatus.score, mistakes: userStatus.recentMistakes, playedGames: userStatus.numPlayedRounds, wonGames: userStatus.numWonRounds)
        }
    }
    
    private func showAlert(with numCorrect: Int) {
        (alertTitle, alertMessage) = game.getAlertTexts(numCorrect: numCorrect)
        showingAlert = true
    }
    
    private func startNewRound() {
        wordsForRound = game.getWordsForRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(game: Game(), userStatus: UserStatus())
    }
}
