//
//  TaskView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 22/05/2021.
//

import SwiftUI

struct TaskView: View {
    var taskWord: Word
    var options: [String]
    var isCorrect: (Bool) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            TaskWordView(taskWord: taskWord)
                .padding(.bottom, 20)
            
            ForEach(options, id: \.self) { option in
                OptionView(text: option, isCorrect: taskWord.synonyms.contains(option)) {
                    isCorrect(taskWord.synonyms.contains(option))
                }
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 30)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            TaskView(taskWord: Game.exampleWord, options: Game().getRandomSynonyms(for: Game.exampleWord)) { _ in

            }
        }
    }
}
