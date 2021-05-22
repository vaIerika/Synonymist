//
//  ContentView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 12/04/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userStatus = UserStatus()
    private let words = Game().getWordsForRound()

    @State private var showUserStatus = false
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
           
            VStack {
                GameView()
                
                // TODO: - ScoreView as a floting view in ZStack, move alert in the GameView
                ScoreView(score: userStatus.score, showUserStatus: $showUserStatus)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("Play more"), action: {
                   // self.restartGame()
                }))
            }
            
            .sheet(isPresented: $showUserStatus) {
                UserStatusView(score: userStatus.score, mistakes: userStatus.recentMistakes, playedGames: userStatus.numPlayedRounds, wonGames: userStatus.numWonRounds)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
