//
//  UserStatus.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 20/05/2021.
//

import Foundation

class UserStatus: ObservableObject, Codable {
    @Published var score: Int
    @Published var numPlayedRounds: Int
    @Published var numWonRounds: Int
    @Published var recentMistakes: [Word]
    
    func finishGame(correctAnswers: Int, totalTasks: Int = Game.numTasksInRound, numPointsPerCorrectAnswer: Int = Game.pointsPerCorrectAnswer, mistakes: Set<Word>) {
       
        let earnings = correctAnswers * numPointsPerCorrectAnswer
        increase(.score, amount: earnings)
        increase(.numPlayedRounds)
        
        if correctAnswers >= totalTasks && mistakes.isEmpty {
            increase(.numWonRounds)
        }
        
        mistakes.forEach { addMistake($0) }
        print("Finish game with \(earnings), mistakes: \(mistakes.count)")

        save()
    }
    
    enum Status { case score, numPlayedRounds, numWonRounds }

    private func increase(_ status: Status, amount: Int = 1) {
        switch status {
        case .score:
            guard score + amount < UserStatus.maxScore else {
                return score = UserStatus.maxScore
            }
            score += amount
            print("Score \(score)")
            
        case .numPlayedRounds:
            if numPlayedRounds < UserStatus.maxPlayedRounds {
                numPlayedRounds += 1
            }
            
        case .numWonRounds:
            if numWonRounds < UserStatus.maxPlayedRounds {
                numWonRounds += 1
            }
        }
    }
    
    private func addMistake(_ word: Word) {
        if let index = recentMistakes.firstIndex(of: word) {
            recentMistakes.remove(at: index)
        }
        recentMistakes.insert(word, at: 0)
        
        while recentMistakes.count > UserStatus.maxRecentMistakes {
            recentMistakes.removeLast()
        }
        save()
    }
    
    // MARK: - Constants
    static let maxScore = 9999
    static let maxPlayedRounds = 999
    static let maxRecentMistakes = 6
    
    // MARK: -  Initializers & Codable methods
    enum CodingKeys: CodingKey {
        case score, numPlayedGames, numWonGames, mistakes
    }
    
    static let saveKey = "SynonymistUserStatus"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode(UserStatus.self, from: data) {
                recentMistakes = decoded.recentMistakes
                score = decoded.score
                numPlayedRounds = decoded.numPlayedRounds
                numWonRounds = decoded.numWonRounds
                return
            }
        }
        score = 0
        numPlayedRounds = 0
        numWonRounds = 0
        recentMistakes = []
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        score = try container.decode(Int.self, forKey: .score)
        numPlayedRounds = try container.decode(Int.self, forKey: .numPlayedGames)
        numWonRounds = try container.decode(Int.self, forKey: .numWonGames)
        recentMistakes = try container.decode([Word].self, forKey: .mistakes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(score, forKey: .score)
        try container.encode(numPlayedRounds, forKey: .numPlayedGames)
        try container.encode(numWonRounds, forKey: .numWonGames)
        try container.encode(recentMistakes, forKey: .mistakes)
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
}
