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
    
    func finishRound(isVictory: Bool, earnings: Int, mistakes: Word...) {
        increase(.score, amount: earnings)
        increase(.numPlayedRounds)
        if isVictory { increase(.numWonRounds) }
        
        for mistake in mistakes {
            addMistake(mistake)
        }
    }
    enum Status { case score, numPlayedRounds, numWonRounds }

    private func increase(_ status: Status, amount: Int = 1) {
        switch status {
        case .score:
            guard score + amount < UserStatus.maxScore else {
                return score = UserStatus.maxScore
            }
            score += amount
            
        case .numPlayedRounds:
            if numPlayedRounds < UserStatus.maxRounds {
                numPlayedRounds += 1
            }
            
        case .numWonRounds:
            if numWonRounds < UserStatus.maxRounds {
                numWonRounds += 1
            }
        }
    }
    
    private func addMistake(_ word: Word) {
        if let index = recentMistakes.firstIndex(of: word) {
            recentMistakes.remove(at: index)
        }
        recentMistakes.insert(word, at: 0)
        
        while recentMistakes.count > 5 {
            recentMistakes.removeLast()
        }
        save()
    }
    
    // MARK: - Constants
    static let maxScore = 9999
    static let maxRounds = 999
    
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
        if let encoded = try? JSONEncoder().encode(recentMistakes) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
}
