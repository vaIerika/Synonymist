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

extension Word: Equatable, Hashable {
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.word == rhs.word
    }
}
