//
//  TasksBulletsView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 16/04/2020.
//

import SwiftUI

struct TasksBulletsView: View {
    var progress: [TaskBullet]
    var currentTaskIndex: Int
    var tasksInRound: Int = Game.numTasksInRound
    
    var body: some View {
        VStack {
            Text("Question \(currentTaskIndex + 1) / \(tasksInRound)".uppercased())
                .fontMavenPro(.footnote)
            HStack {
                ForEach(progress, id: \.self) { question in
                    question
                }
            }
            .padding(.top, 8)
        }
        .padding(.vertical, 30)
    }
}

struct TaskBullet: View, Hashable {
    var isCorrect: Bool?
    
    private var isAnswered: Bool {
        isCorrect != nil ? true : false
    }
    
    var body: some View {
        Circle()
            .stroke(Color.ghostWhite, lineWidth: 1)
            .opacity(isAnswered ? 0 : 1)
            .frame(width: 10, height: 10)
            .overlay(
                Circle()
                    .foregroundColor(isCorrect ?? true ? .turquoise : .darkViolet)
                    .opacity(isAnswered ? 1 : 0)
            )
    }
}

struct TasksBulletsView_Previews: PreviewProvider {
    static var previews: some View {
        TasksBulletsView(progress: [
                        TaskBullet(isCorrect: true),
                        TaskBullet(isCorrect: false),
                        TaskBullet(isCorrect: true),
                        TaskBullet(isCorrect: nil),
                        TaskBullet()], currentTaskIndex: 3)
            .background(Image("background"))
    }
}
