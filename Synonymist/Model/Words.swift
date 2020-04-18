//
//  Words.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 14/04/2020.
//

import Foundation
import SwiftUI

class Word: Identifiable, Codable, Equatable {

    var id: String
    var word: String
    var meaning: String
    var synonyms: [String]
    
    init(id: String, word: String, meaning: String, synonyms: [String]) {
        self.id = id
        self.word = word
        self.meaning = meaning
        self.synonyms = synonyms
    }
    
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.word == rhs.word
    }
}

struct Words_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
