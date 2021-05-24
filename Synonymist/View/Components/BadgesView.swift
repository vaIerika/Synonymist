//
//  BadgesView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 16/04/2020.
//

import SwiftUI

struct BadgesView: View {
    let badges = Rewards().badges
    var userStatus: UserStatus
    
    @State private var badgeTitle = ""
    @State private var badgeDescription = ""
    @State private var showingBadgeDescription = false
    
    var body: some View {
        VStack {
            Text("Badges")
                .titleWithWave()
            
            HStack(spacing: 20) {
                ForEach(badges) { badge in
                    Button(action: {
                        badgeTitle = badge.name
                        badgeDescription = badge.info + " " + badge.getStatus(status: userStatus).message
                        withAnimation {
                            showingBadgeDescription = true
                        }
                    }) {
                        BadgeView(image: badge.imageName, earned: badge.getStatus(status: userStatus).isEarned)
                    }
                }
            }.padding(.bottom, 25)
            
            if showingBadgeDescription {
                VStack(spacing: 10) {
                    Text(badgeTitle)
                        .fontMavenPro(.title3, weight: .bold)
                    Text(badgeDescription)
                        .fontMavenPro(.footnote)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct BadgeView: View {
    var image: String
    var earned: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.turquoise)
                .opacity(earned ? 1 : 0.3)
            Image(systemName: image)
                .font(.title)
                .frame(width: 40, height: 40)
                .foregroundColor(.ghostWhite)
                .opacity(earned ? 1 : 0.3)
        }
    }
}

struct BadgesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BadgesView(userStatus: UserStatus())
        }
        .background(Image("background"))
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        let badges = Rewards().badges
        VStack(spacing: 30) {
            HStack {
                ForEach(badges) { badge in
                    BadgeView(image: badge.imageName, earned: false)
                }
            }
            HStack {
                ForEach(badges) { badge in
                    BadgeView(image: badge.imageName, earned: true)
                }
            }
        }.background(Image("background"))
    }
}
