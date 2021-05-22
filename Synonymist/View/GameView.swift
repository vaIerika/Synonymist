//
//  GameView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 22/05/2021.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var userStatus = UserStatus()
    private let game = Game()
    
    let wordsForRound = Game().getWordsForRound()
    @State private var currentTaskIndex: Int = 0
    @State private var correctAnswers: Int = 0
    
    private var tasksInRound: Int {
        Game().getWordsForRound().count
    }
    @State private var progress = Array(repeating: Question(), count: Game().getWordsForRound().count)
    
    var body: some View {
        VStack {
            // TODO: - Create question view
            Text("Question \(currentTaskIndex + 1) / \(tasksInRound)".uppercased())
                .fontMavenPro(.footnote)
            
            HStack {
                ForEach(progress, id: \.self) { question in
                    question
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 30)
            
        TaskView(taskWord: wordsForRound[currentTaskIndex]) { isCorrect in
            isCorrect ? hapticsSuccess() : hapticsError()
            nextQuestion()
        }
        .padding(.bottom,30)
        
        }
    }

    private func nextQuestion() {
        guard currentTaskIndex < tasksInRound - 1 else { return finishGame() }
        
        currentTaskIndex += 1
        print("next question")
    }
    
    private func finishGame() {
        // alert
        // update viewmodel
        print("alert")
        /*
         (alertTitle, alertMessage) = Game().getAlertTexts(answeredCorrect: correctQuestionsInGame)
         showingAlert = true
         */
    }
    
    private func hapticsSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    private func hapticsError() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    
    /*
     func changeProgress() {
         if userAnswer != nil {
             if userAnswer == true {
                 progress[questionNumber - 1].correct = true
             } else {
                 progress[questionNumber - 1].correct = false
             }
         }
     }
     func restartGame() {
         countWonGames()
         userStatus.numPlayedRounds += 1
         questionNumber = 1
         correctQuestionsInGame = 0
         progress = Array(repeating: Question(correct: nil), count: Self.numberOfQuestions)
         //randomiseWords()
     }
     */
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .background(
                Image("background")
            )
    }
}
