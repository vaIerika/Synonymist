//
//  UserStatusView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 15/04/2020.
//

import SwiftUI

struct UserStatusView: View {
    @State private var badgeTitle = ""
    @State private var badgeDescription = ""
    @State private var showingBadgeDescription = false

    var score: Int
    var mistakes: [Word]
    var playedGames: Int
    var wonGames: Int
    
    var body: some View {
        
        // Badges
        let badgeDetails = [(title: "Smarty Pants", info: "For a game without mistake."),
                            (title: "Know-It-All", info: "Get it for 20 games. You played \(playedGames) games for now."),
                            (title: "Wise Guy", info: "If you achieve a 100-points score."),
                            (title: "Senior Synonimist", info: "Finish 50 games without a mistake. Now you've won \(wonGames) games.")
        ]
        
        var badgeNoMistakes: Bool {
            if playedGames > 0 && wonGames > 0 {
                return true
            }
            return false
        }
        
        var badge20Games: Bool {
            if playedGames >= 20 {
                return true
            }
            return false
        }
        
        var badge100Points: Bool {
            if score >= 100 {
                return true
            }
            return false
        }
        
        var badge50WonGames: Bool {
            if wonGames >= 50 {
                return true
            }
            return false 
        }
        
        return ZStack {
           Image("backgroundScoreView")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("SCORE: \(score)")
                    .font(.custom("MavenPro-Bold", size: 30))
                    .padding(.top, 100)
                    .padding(.bottom, 50)
                
                VStack {
                    Image("wave")
                    Text("RECENT MISTAKES")
                        .font(.custom("MavenPro-SemiBold", size: 21))
                        .padding(.bottom, 30)
                    if mistakes.isEmpty {
                        Text("You have not made any mistakes")
                            .font(.custom("MavenPro-Bold", size: 15))
                    } else {
                        if mistakes.count <= 3 {
                            
                            // only one row
                            HStack {
                                ForEach(0..<mistakes.count, id: \.self) { index in
                                    Text(self.mistakes[index].word)
                                        .font(.custom("MavenPro-Bold", size: 15))
                                        .padding(.horizontal, 25)
                                        .padding(.vertical, 10)
                                        .background(Color.turquoise.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                            .padding(.bottom)
                        } else {
                            
                            // 1st row
                            HStack {
                                ForEach(0..<3, id: \.self) { index in
                                    Text(self.mistakes[index].word)
                                        .font(.custom("MavenPro-Bold", size: 15))
                                        .padding(.horizontal, 25)
                                        .padding(.vertical, 10)
                                        .background(Color.turquoise.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }.padding(.bottom)
                            
                            // 2nd row 
                            HStack {
                                ForEach(3..<mistakes.count, id: \.self) { index in
                                    Text(self.mistakes[index].word)
                                        .font(.custom("MavenPro-Bold", size: 15))
                                        .padding(.horizontal, 25)
                                        .padding(.vertical, 10)
                                        .background(Color.turquoise.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 50)
                
                VStack {
                    Image("wave")
                    Text("BADGES")
                        .font(.custom("MavenPro-SemiBold", size: 21))
                        .padding(.bottom, 10)
                    HStack(spacing: 20) {
                        Button(action: {
                            self.badgeTitle = badgeDetails[0].title
                            self.badgeDescription = badgeDetails[0].info
                            self.showingBadgeDescription = true
                        }) {
                            Badge(image: "eyeglasses", earned: badgeNoMistakes)
                        }
                        Button(action: {
                            self.badgeTitle = badgeDetails[1].title
                            self.badgeDescription = badgeDetails[1].info
                            self.showingBadgeDescription = true
                        }) {
                            Badge(image: "gamecontroller.fill", earned: badge20Games)
                        }
                        Button(action: {
                            self.badgeTitle = badgeDetails[2].title
                            self.badgeDescription = badgeDetails[2].info
                            self.showingBadgeDescription = true
                        }) {
                            Badge(image: "star.fill", earned: badge100Points)
                        }
                        Button(action: {
                            self.badgeTitle = badgeDetails[3].title
                            self.badgeDescription = badgeDetails[3].info
                            self.showingBadgeDescription = true
                        }) {
                            Badge(image: "rosette", earned: badge50WonGames)
                        }
                    }
                    
                    VStack(spacing: 10) {
                        Text(badgeTitle)
                            .font(.custom("MavenPro-Bold", size: 15))
                        Text(badgeDescription)
                            .font(.custom("MavenPro-SemiBold", size: 13))
                    }
                    .padding(.horizontal)
                    .padding(.top, 15)
                    .opacity(showingBadgeDescription ? 1 : 0)
                }
                Spacer()
            }
            .foregroundColor(.ghostWhite)
        }
    }
}

struct UserStatusView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatusView(score: 108, mistakes: [
            Word(word: "significant", meaning: "", synonyms: []),
            Word(word: "outstanding", meaning: "", synonyms: []),
            Word(word: "egregious", meaning: "", synonyms: []),
            Word(word: "shamefaced", meaning: "", synonyms: []),
            Word(word: "sharp-tempered", meaning: "", synonyms: []),
        ], playedGames: 100, wonGames: 0)
    }
}
