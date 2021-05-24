//
//  Badge.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 23/05/2021.
//

import Foundation

struct Badge: Codable, Hashable {
    var name: String
    var info: String
    var criterion: String
    var aim: Int
}

extension Badge: Identifiable {
    enum BadgeId { case smarty, knowAll, wise, senior, unknown }
    
    var id: BadgeId {
        switch name {
        case "Smarty Pants": return .smarty
        case "Know-It-All": return .knowAll
        case "Wise Guy": return .wise
        case "Senior Synonymist": return .senior
        default: return .unknown
        }
    }
}

extension Badge {
    var imageName: String {
        switch id {
        case .smarty: return "eyeglasses"
        case .knowAll: return "gamecontroller.fill"
        case .wise: return "star.fill"
        case .senior: return "rosette"
        case .unknown: return "questionmark.diamond.fill"
        }
    }
}

extension Badge {
    func getStatus(status userStatus: UserStatus) -> (isEarned: Bool, message: String) {
        var isEarned = false
        var message = ""
        
        switch criterion {
        case "victory":
            isEarned = userStatus.numWonRounds >= aim
            message = userStatus.numWonRounds <= 0
                ? "You haven't won yet."
                : "You won \(userStatus.numWonRounds) rounds."
            
        case "rounds":
            isEarned = userStatus.numPlayedRounds >= aim
            message = userStatus.numPlayedRounds <= 0
                ? "You haven't played yet."
                : "You finished \(userStatus.numPlayedRounds) rounds."
            
        case "score":
            isEarned = userStatus.score >= aim
            message = "Your current score is \(userStatus.score)."
        default: break
        }
        
        return (isEarned, message)
    }
}

class Rewards {
    let badges: [Badge] = Bundle.main.decode("badges.json")
}
