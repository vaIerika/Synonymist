//
//  GameView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 22/05/2021.
//

import SwiftUI

struct GameView: View {
    let game: Game
    var wordsForRound: [Word]
    var sendGameResults: (Int, Set<Word>) -> Void

    @State private var progress: [TaskBullet]
    @State private var currentTaskIndex: Int = 0
    @State private var correctAnswers: Int = 0
    @State private var mistakes: Set<Word> = []
    @State private var randomSynonyms: [String] = []

    private var tasksInRound: Int {
       wordsForRound.count
    }
    
    init(game: Game, wordsForRound: [Word], sendGameResults: @escaping (Int, Set<Word>) -> Void) {
        self.game = game
        self.wordsForRound = wordsForRound
        self.sendGameResults = sendGameResults
        _progress = State(initialValue: Array(repeating: TaskBullet(), count: wordsForRound.count))
    }
    
    var body: some View {
        VStack {
            TasksBulletsView(progress: progress, currentTaskIndex: currentTaskIndex)
            TaskView(
                taskWord: wordsForRound[currentTaskIndex],
                //options: game.getRandomSynonyms(for: wordsForRound[currentTaskIndex])
                options: randomSynonyms
            ) { isCorrect in
                receiveAnswer(isCorrect)
            }
            Spacer()
        }
        .padding(.top, 25)
        .onAppear {
            if currentTaskIndex == 0 && !wordsForRound.isEmpty {
                //randomSynonyms = game.getRandomSynonyms(for: wordsForRound[currentTaskIndex])
                getRandomSynonyms(from: wordsForRound)
            }
        }
        .onChange(of: wordsForRound) { newValue in
            restartGame()
            getRandomSynonyms(from: newValue)
                //game.getRandomSynonyms(for: newValue[currentTaskIndex])
        }
    }
    
    private func getRandomSynonyms(from words: [Word]) {
        randomSynonyms = game.getRandomSynonyms(for: words[currentTaskIndex])
    }
    
    private func receiveAnswer(_ isCorrect: Bool) {
        changeProgress(isCorrect: isCorrect)
        if isCorrect {
            hapticsSuccess()
            correctAnswers += 1
        } else {
            hapticsError()
            mistakes.insert(wordsForRound[currentTaskIndex])
        }
        nextQuestion()
    }
    
    private func nextQuestion() {
        guard currentTaskIndex < tasksInRound - 1 else { return finishGame() }
        currentTaskIndex += 1
        //randomSynonyms = game.getRandomSynonyms(for: wordsForRound[currentTaskIndex])
        getRandomSynonyms(from: wordsForRound)
    }
    
    private func finishGame() {
        sendGameResults(correctAnswers, mistakes)
    }

    private func changeProgress(isCorrect: Bool) {
        guard currentTaskIndex < progress.count else { return }
        withAnimation(.easeOut(duration: 0.3)) {
            progress[currentTaskIndex].isCorrect = isCorrect
        }
    }
    
     private func restartGame() {
        currentTaskIndex = 0
        correctAnswers = 0
        mistakes = []
        progress = Array(repeating: TaskBullet(), count: tasksInRound)
     }
    
    // MARK: - Haptics
    private func hapticsSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    private func hapticsError() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game(), wordsForRound: [Game.exampleWord]) { _, _ in
            
        }
        .background(
            Image("background")
        )
    }
}
