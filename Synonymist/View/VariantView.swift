//
//  VariantView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 16/04/2020.
//

import SwiftUI

struct VariantView: View {
    @State private var bgColor = Color.violet
    @State private var opacityAmount = 0.4
    
    var variant: String
    var correct: Bool?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .frame(width: 300, height: 62, alignment: .center)
                .foregroundColor(bgColor)
                .opacity(opacityAmount)
                .onAppear {
                    if self.correct != nil {
                        self.animationEffect()
                    }
                }

            Text(variant.capitalized)
                .font(.custom("MavenPro-Black", size: 17))
                .foregroundColor(.ghostWhite)
        }
    }
    
    func animationEffect() {
        withAnimation {
            if self.correct ?? true {
                self.bgColor = .turquoise
                self.opacityAmount = 1
            } else if !(self.correct ?? true) {
                self.bgColor = .darkViolet
                self.opacityAmount = 1
            }
        }
    }
}

struct VariantView_Previews: PreviewProvider {
    static var previews: some View {
        VariantView(variant: "Wonderful", correct: true)
    }
}
