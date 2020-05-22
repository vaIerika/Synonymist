//
//  Words.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 14/04/2020.
//

import Foundation
import SwiftUI

class Word: Codable, Equatable {

    var word: String
    var meaning: String
    var synonyms: [String]
    
    init(word: String, meaning: String, synonyms: [String]) {
        self.word = word
        self.meaning = meaning
        self.synonyms = synonyms
    }
    
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.word == rhs.word
    }
}
