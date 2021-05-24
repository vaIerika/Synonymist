//
//  Text+TitleWithWaveViewModifier.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 24/05/2021.
//

import SwiftUI

struct TitleWithWaveViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontMavenPro(.title3, weight: .semiBold)
            .textCase(.uppercase)
            .padding()
            .background(
                Image("wave")
                    .offset(y: -30)
            )
    }
}

extension Text {
    func titleWithWave() -> some View {
        self.modifier(TitleWithWaveViewModifier())
    }
}

struct TitleWithWaveViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Badges")
            .titleWithWave()
            .background(Image("background"))
    }
}
