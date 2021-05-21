//
//  Font+MavenPro.swift
//  Synonymist
//
//  Created by Valerie 👩🏼‍💻 on 21/05/2021.
//

import SwiftUI

struct MavenProTextViewModifier: ViewModifier {
    enum Weight { case semiBold, bold, black }
    
    var style: UIFont.TextStyle
    var weight: Weight
    var color: Color
    
    private var fontName: String {
        switch weight {
        case .semiBold: return "MavenPro-SemiBold"
        case .bold: return "MavenPro-Bold"
        case .black: return "MavenPro-Black"
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: UIFont.preferredFont(forTextStyle: style).pointSize))
            .foregroundColor(color)
    }
}

extension View {
    func fontMavenPro(
        _ style: UIFont.TextStyle = .body,
        weight: MavenProTextViewModifier.Weight = .bold,
        color: Color = .ghostWhite
    ) -> some View {
        
        self.modifier(MavenProTextViewModifier(style: style, weight: weight, color: color))
    }
}
