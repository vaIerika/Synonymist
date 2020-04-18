//
//  Badge.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 16/04/2020.
//

import SwiftUI

struct Badge: View {
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
                .opacity(earned ? 1: 0.3)
        }
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge(image: "eyeglasses", earned: true)
    }
}
