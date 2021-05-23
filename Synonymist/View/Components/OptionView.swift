//
//  OptionView.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 22/05/2021.
//

import SwiftUI

struct OptionView: View {
    var text: String
    var isCorrect: Bool
    var action: () -> Void
    
    @State private var animate = false
    @State private var scaleEffect = false
   // @State private var fontScaleAnimation = false
    
    var body: some View {
        Text(text.lowercased())
            .fontMavenPro(weight: .black)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 300, height: 62, alignment: .center)
                    .foregroundColor(getBgColor())
                    .opacity(animate ? 1 : 0.4)
            )
            .scaleEffect(scaleEffect ? 1.1 : 1)
            .overlay(
                ZStack {
                    if animate && isCorrect {
                        LottieViewRepresentative(loopMode: .playOnce)
                            .frame(width: 200, height: 200)
                    }
                }
            )
            .padding(10)
            .onTapGesture {
                withAnimation(.spring()) {
                    animate = true
                    scaleEffect = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        scaleEffect = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        action()
                        animate = false 
                    }
                }
            }
    }
    
    private func getBgColor() -> Color {
        if !animate { return Color.violet }
        return isCorrect && animate ? .turquoise : .darkViolet
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OptionView(text: "Unforced", isCorrect: false) { }
            OptionView(text: "Spontaneous", isCorrect: true) { }
        }
            .background(Image("background"))
    }
}
