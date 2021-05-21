//
//  Word.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 14/04/2020.
//

import Foundation

struct Word: Codable {
    var word: String
    var meaning: String
    var synonyms: [String]
}

extension Word: Equatable {
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.word == rhs.word
    }
}

class Game {
    let words: [Word] = Bundle.main.decode("words.json")
    static let numWordsInRound = 5
    
    func getWordsForRound(amount: Int = numWordsInRound) -> [Word] {
        //var wordsToPlay: [Word] = Array(words.shuffled().dropFirst(amount))

        return Array(words.shuffled().dropFirst(amount))
    }
}
