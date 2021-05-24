//
//  UserStatusView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 15/04/2020.
//

import SwiftUI

struct UserStatusView: View {
    var userStatus: UserStatus
    
    var body: some View {
        VStack(spacing: 65) {
            Text("Score: \(userStatus.score)".uppercased())
                .fontMavenPro(.title1)
            UserMistakesView(mistakes: userStatus.recentMistakes)
            BadgesView(userStatus: userStatus)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("backgroundScoreView")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}


struct UserStatusView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatusView(userStatus: UserStatus())
    }
}
