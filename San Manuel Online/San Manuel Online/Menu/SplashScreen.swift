//
//  SplashScreen.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 03.12.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            
            
            VStack {
                Spacer()
                TextWithBorder(text: "LOADING...", font: .custom(Fonts.mazzardM.rawValue, size: 60), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                Spacer()
            }
        }.background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
}

#Preview {
    SplashScreen()
}

struct TextWithBorder: View {
    let text: String
    let font: Font
    let textColor: Color
    let borderColor: Color
    let borderWidth: CGFloat

    var body: some View {
        ZStack {
            // Multiple layers of text for the border effect
            ForEach([1, 1], id: \.self) { xOffset in
                ForEach([1, 1], id: \.self) { yOffset in
                    Text(text)
                        .font(font)
                        .foregroundColor(borderColor)
                        .offset(x: CGFloat(xOffset) * borderWidth, y: CGFloat(yOffset) * borderWidth)
                }
            }
            .offset(x: 1, y: 1)
            // Main text layer
            Text(text)
                .font(font)
                .foregroundColor(textColor)
        }
    }
}
   
    
//.offset(x: -2, y: 2)

