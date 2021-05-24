//
//  Game.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 22/05/2021.
//

import Foundation

class Game {
    private let words: [Word] = Bundle.main.decode("words.json")

    func getWordsForRound(amount: Int = numTasksInRound) -> [Word] {
        guard amount > 0 else { return [] }
        return Array(words.shuffled().prefix(amount))
    }
    
    func getRandomSynonyms(for taskWord: Word, amount: Int = numOptionsForTask) -> [String] {
        guard !taskWord.synonyms.isEmpty && amount > 1 else {
            print("Wrong input to get random synonyms.")
            return []
        }
        
        var synonyms = [taskWord.synonyms.shuffled()[0]]
        print("Taskword: \(taskWord.word). Correct synonym: \(synonyms)")
        let wordsToGetSynonymsFrom = words.shuffled().filter { $0 != taskWord }.prefix(amount - 1)
        
        for word in wordsToGetSynonymsFrom {
            synonyms.append(word.synonyms.filter { !synonyms.contains($0) }.randomElement() ?? "Default")
        }
        return synonyms.shuffled()
    }
    
    func getAlertTexts(numCorrect: Int, total numTotalWordsInRound: Int = Game.numTasksInRound) -> (title: String, message: String) {
        let earnedPoints = numCorrect * Game.pointsPerCorrectAnswer
        
        switch numCorrect {
        case ...0:
            return (title: "Ups! It was a quite hard game.",
                    message: "You haven't earned any points during this game. \nBut don't worry it will get better with practice.")
        case 1..<4:
            return (title: "Not bad.",
                    message: "The more you practise the better you get! \n\(earnedPoints) points for this game.")
        case 4..<numTotalWordsInRound:
            return (title: "Keep it up!",
                    message: "You have increased your score for \(earnedPoints) points.")
        default:
            return (title: "Impressive!",
                    message: "You've answered all the questions correctly! \nYou have earned \(earnedPoints) points.")
        }
    }

    // MARK: - Constants
    static let numTasksInRound = 5
    static let numOptionsForTask = 4
    static let pointsPerCorrectAnswer = 1
    
    static let exampleWord = Word(
        word: "latent",
        meaning: "Remaining in a non-active or hidden phase",
        synonyms: ["dead", "dormant", "fallow", "free", "idle", "inactive", "inert", "inoperative", "off", "unused", "vacant"]
    )
}
