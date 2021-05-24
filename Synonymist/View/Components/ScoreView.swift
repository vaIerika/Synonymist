//
//  ScoreView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 22/05/2021.
//

import SwiftUI

struct ScoreView: View {
    var score: Int
    @Binding var showUserStatus: Bool

    var body: some View {
        Button(action: {
            showUserStatus = true
        }) {
            HStack(spacing: 10) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.turquoise)
                Text("Score: \(score)".uppercased())
                    .fontMavenPro(.footnote)
            }
            .foregroundColor(.ghostWhite)
            .padding(.bottom, 50)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 100, showUserStatus: .constant(false))
            .background(
                Image("background")
            )
    }
}
