//
//  TextBg.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 03.12.2024.
//

import SwiftUI

enum TextBgType {
    case black, gold
}

struct TextBg: View {
    var type: TextBgType = .gold
    var height: CGFloat
    var text: String
    var textSize: CGFloat
    var body: some View {
        ZStack {
            if type == .black {
                Image(.textBlackBg)
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
            } else {
                Image(.textGoldBg)
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
            }
            
            TextWithBorder(text: text, font: .custom(Fonts.mazzardM.rawValue, size: textSize), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 3)
                .textCase(.uppercase)
            
                
        }
    }
}

#Preview {
    TextBg(height: 100, text: "Loading...", textSize: 32)
}
