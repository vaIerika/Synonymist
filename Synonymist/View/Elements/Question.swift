//
//  Question.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 16/04/2020.
//

import SwiftUI

struct Question: View {
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
