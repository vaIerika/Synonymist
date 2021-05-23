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

class Rewards {
    let badges: [Badge] = Bundle.main.decode("badges.json")
}
