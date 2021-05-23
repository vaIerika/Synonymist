//
//  TaskWordView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 22/05/2021.
//

import SwiftUI

struct TaskWordView: View {
    var taskWord: Word
    @State private var showHint = false
    
    var body: some View {
        VStack {
            Text("Find a synonym for")
                .fontMavenPro()
                .padding(.bottom, 5)
            HStack(spacing: 10) {
                Text(taskWord.word.uppercased())
                    .fontMavenPro(.title3, weight: .black)
                    .padding(.leading, 40)
                
                Button(action: {
                    withAnimation {
                        showHint = true
                    }
                }) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.turquoise)
                }
                .frame(width: 30, height: 30)
            }
            Text(taskWord.meaning)
                .fontMavenPro(.footnote, weight: .semiBold)
                .multilineTextAlignment(.center)
                .opacity(showHint ? 1 : 0)
        }
        .padding(.horizontal)
        .onChange(of: taskWord) { _ in
            showHint = false 
        }
    }
}

struct TaskWordView_Previews: PreviewProvider {
    static var previews: some View {
        TaskWordView(taskWord: Game.exampleWord)
            .background(Image("background"))
    }
}
