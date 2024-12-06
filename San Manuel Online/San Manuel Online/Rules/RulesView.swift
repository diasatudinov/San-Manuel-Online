//
//  RulesView.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 03.12.2024.
//

import SwiftUI

struct RulesView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            WV(url: URL(string: Links.ruleURL)!)
            VStack {
                ZStack {
//                    HStack {
//                        Spacer()
//                        TextWithBorder(text: "Rules ", font: .custom(Fonts.mazzardM.rawValue, size: 55), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
//                            .textCase(.uppercase)
//                        
//                        Spacer()
//                    }
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Image(.backBtn)
                                    .resizable()
                                    .scaledToFit()
                                
                                
                                
                            }.frame(height: 65)
                            
                        }
                        Spacer()
                    }.padding()
                }
//                
//                
//                TextWithBorder(text: "The player starts with 6 amulets of different colors, which are located at the bottom of the screen (inventory). The player pulls the selected amulet onto an empty cell. After placing the amulet, it disappears, and a new amulet appears in the inventory.\nOpponent's Actions (AI): The opponent chooses amulets of the same type as the player, but they are marked with a different color. His goal is to block strategically important player moves or try to collect the most points. ", font: .custom(Fonts.mazzardM.rawValue, size: 26), textColor: .mainBrown, borderColor: .mainYellow, borderWidth: 2)
//                    .textCase(.uppercase)
//                    .multilineTextAlignment(.center)
//                    .minimumScaleFactor(0.5)
//                
                
                Spacer()
            }
        }
        .background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
}

#Preview {
    RulesView()
}
