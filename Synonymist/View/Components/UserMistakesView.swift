//
//  UserMistakesView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 24/05/2021.
//

import SwiftUI

struct UserMistakesView: View {
    var mistakes: [Word]
    
    private let rows: [GridItem] = [
        GridItem(.flexible(minimum: 40, maximum: 50)),
        GridItem(.flexible(minimum: 40, maximum: 50)),
        GridItem(.flexible(minimum: 40, maximum: 50))
    ]
    
    var body: some View {
        VStack {
            Text("Recent mistakes")
                .titleWithWave()
            
            if mistakes.isEmpty {
                Text("You haven't made any mistake.")
                    .fontMavenPro(.headline, weight: .semiBold)
            } else {
                LazyHGrid(rows: rows, alignment: .center, spacing: 10) {
                    ForEach(mistakes, id: \.self) { mistake in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(mistake.word)
                                .fontMavenPro(.footnote, weight: .bold)
                                .padding(10)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.turquoise.opacity(0.2))
                                )
                        }
                    }
                }
            }
        }
    }
}

struct UserMistakesView_Previews: PreviewProvider {
    static var previews: some View {
        UserMistakesView(mistakes: [
            Word(word: "significant", meaning: "", synonyms: []),
            Word(word: "outstanding", meaning: "", synonyms: []),
            Word(word: "egregious", meaning: "", synonyms: []),
            Word(word: "shamefaced", meaning: "", synonyms: []),
            Word(word: "sharp-tempered", meaning: "", synonyms: []),
            Word(word: "wineglassful", meaning: "", synonyms: [])
        ])
        .frame(height: 400)
        .background(Image("background"))
    }
}
