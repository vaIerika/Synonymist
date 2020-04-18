//
//  Words.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 14/04/2020.
//

import Foundation
import SwiftUI

class Word: Identifiable, Equatable {
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.word == rhs.word 
    }
    
    var id = UUID()
    var word: String
    var meaning: String
    var synonyms: [String]
    
    init(word: String, meaning: String, synonyms: [String]) {
        self.word = word
        self.meaning = meaning
        self.synonyms = synonyms
    }
}

class Words: ObservableObject {
    @Published var collection: [Word]
    
    init() {
        self.collection = []
        let word1 = Word(word: "cogent", meaning: "Reasonable; based on evidence", synonyms: [
            "compelling", "conclusive", "convincing", "decisive", "effective", "forceful", "persuasive", "satisfying", "strong", "telling"
        ])

        let word2 = Word(word: "egregious", meaning: "Outrageously bad; shocking", synonyms: [
            "blatant", "conspicuous", "flagrant", "glaring", "gross", "obvious", "patent", "pronounced", "rank", "striking"
        ])

        let word3 = Word(word: "latent", meaning: "Remaining in a non-active or hidden phase", synonyms: [
            "dead", "dormant", "fallow", "free", "idle", "inactive", "inert", "inoperative", "off", "unused", "vacant"
        ])

        let word4 = Word(word: "restive", meaning: "Impatient; resistant to control", synonyms: [
            "balky", "contrary", "contumacious", "defiant", "disobedient", "froward", "incompliant", "insubordinate", "intractable", "obstreperous", "rebel", "rebellious", "recalcitrant", "recusant", "refractory", "ungovernable", "unruly", "untoward", "wayward", "willful / wilful"
        ])

        let word5 = Word(word: "great", meaning: "Extreme or more than usual; of significant importance", synonyms: [
            "noteworthy", "worthy", "distinguished", "remarkable", "grand", "considerable", "powerful", "much", "mighty"
        ])
            
        let word6 = Word(word: "lazy", meaning: "Showing a lack of effort or care", synonyms: [
            "indolent", "slothful", "idle", "inactive", "sluggish"
        ])
        self.collection.append(word1)
        self.collection.append(word2)
        self.collection.append(word3)
        self.collection.append(word4)
        self.collection.append(word5)
        self.collection.append(word6)
    }
}

struct Words_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
