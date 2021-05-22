//
//  Question.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 16/04/2020.
//

import SwiftUI

struct QuestionsView: View {
    static let numberOfQuestions = 5
    @State private var questionNumber = 1

    @State private var progress = Array(repeating: Question(), count: numberOfQuestions)

    var body: some View {
        Group {
        Text("QUESTION \(questionNumber) / 5")
            .fontMavenPro(.footnote)
        
        HStack {
            ForEach(0..<progress.count, id: \.self) { i in
                self.progress[i]
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 30)
        }
    }
}


struct Question: View, Hashable {
    var correct: Bool?
    
     var body: some View {
         var opacityAmount: Double {
             if correct != nil {
                 return 1.0
             }
             return 0.0
         }
         
         return Circle()
             .stroke(Color.ghostWhite, lineWidth: 1)
             .opacity(opacityAmount > 0 ? 0 : 1)
             .frame(width: 10, height: 10)
             .overlay(
                 Circle()
                     .foregroundColor(correct ?? true ? .turquoise : .darkViolet)
                     .opacity(opacityAmount)
             )
             .animation(.default)
     }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        Question(correct: true)
    }
}
