//
//  Statistics.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 18/04/2020.
//

import Foundation

class Mistakes: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case mistakes
    }
    
    @Published var mistakes: [Word]
    static let saveKey = "RecentMistakes"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Word].self, from: data) {
                self.mistakes = decoded
                return
            }
        }
        self.mistakes = []
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mistakes = try container.decode([Word].self, forKey: .mistakes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mistakes, forKey: .mistakes)
    }
    

    func addMistake(_ word: Word) {
        if let index = mistakes.firstIndex(of: word) {
            mistakes.remove(at: index)
        }
        mistakes.insert(word, at: 0)
        
        if mistakes.count > 5 {
            mistakes.remove(at: 5)
        }
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(mistakes) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }

}
