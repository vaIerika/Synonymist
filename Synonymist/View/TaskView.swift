//
//  TaskView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 22/05/2021.
//

import SwiftUI

struct TaskView: View {
    var taskWord: Word
    var isCorrect: (Bool) -> Void
    
    private var options: [String] {
        return Game().getRandomSynonyms(for: taskWord)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            TaskWordView(taskWord: taskWord)
                .padding(.bottom, 25)
            
            ForEach(options, id: \.self) { option in
                OptionView(text: option, isCorrect: taskWord.synonyms.contains(option)) {
                    isCorrect(taskWord.synonyms.contains(option))
                }
            }
        }
        .padding(.bottom,30)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            TaskView(taskWord: Game.exampleWord) { _ in
                
            }
        }
    }
}
