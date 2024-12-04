//
//  AchievementsView.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 03.12.2024.
//

import SwiftUI

struct AchievementsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: AchievementsViewModel
    @State private var currentTab: Int = 0

    var body: some View {
        
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            ZStack {
                
                ZStack {
                    
                    if isLandscape {
                        ZStack {
                            // Горизонтальная ориентация
                            VStack(spacing: 0) {
                                
                                TabView(selection: $currentTab) {
                                    achivementView(image: .achivement1, header: "Gold \nCollector", text: "Collect \n100/250/500 coins", isOpen: viewModel.achievementOne)
                                        .tag(0)
                                    achivementView(image: .achivement2, header: "Amulet\nMaster", text: "Collect 10/50/100 \nred amulets", isOpen: viewModel.achievementTwo)
                                        .tag(1)
                                    achivementView(image: .achivement3, header: "Combo\nKing", text: "Win 3/10/20 games \nin a row", isOpen: viewModel.achievementThree)
                                        .tag(2)
                                }
                                .tabViewStyle(.page)
                                
                            }
                            
                        }
                    } else {
                        ZStack {
                            // Горизонтальная ориентация
                            VStack(spacing: 0) {
                                
                                TabView(selection: $currentTab) {
                                    achivementView(image: .achivement1, header: "Gold \nCollector", text: "Collect \n100/250/500 coins", isOpen: viewModel.achievementOne)
                                        .tag(0)
                                    achivementView(image: .achivement2, header: "Amulet\nMaster", text: "Collect 10/50/100 \nred amulets", isOpen: viewModel.achievementTwo)
                                        .tag(1)
                                    achivementView(image: .achivement3, header: "Combo\nKing", text: "Win 3/10/20 games \nin a row", isOpen: viewModel.achievementThree)
                                        .tag(2)
                                }
                                .tabViewStyle(.page)
                                
                            }
                            
                        }
                    }
                    
                }.textCase(.uppercase)
                
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                            TextWithBorder(text: "Achievements", font: .custom(Fonts.mazzardM.rawValue, size: 50), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                .textCase(.uppercase)
                                
                                
                            
                            Spacer()
                        }
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
        
        @ViewBuilder func achivementView(image: ImageResource, header: String, text: String, isOpen: Bool) -> some View {
            
            
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                HStack(spacing: 100) {
                    Button {
                        if currentTab > 0 {
                            currentTab -= 1
                        }
                    } label: {
                        Image(.swipeBtn)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            
                    }
                    
                    TextWithBorder(text: text, font: .custom(Fonts.mazzardM.rawValue, size: 24), textColor: .mainBrown, borderColor: .mainYellow, borderWidth: 2)
                        .textCase(.uppercase)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        if currentTab < 2 { // Adjust based on the number of tabs
                            currentTab += 1
                        }
                    } label: {
                        Image(.swipeBtn)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .rotationEffect(.degrees(180))
                    }
                }
                ZStack {
                    Image(image)
                        .renderingMode(isOpen ? .original : .template)
                        .resizable()
                        .foregroundColor(.black)
                        .scaledToFit()
                        .padding(.bottom, 30)
                    
                    VStack {
                        TextWithBorder(text: header, font: .custom(Fonts.mazzardM.rawValue, size: 20), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                            .textCase(.uppercase)
                            .padding(16)
                            .multilineTextAlignment(.center)
                            .offset(x: -150)
                            
                        Spacer()
                    }
                }.frame(height: 250)
                
                
            }
            
        }
}

#Preview {
    AchievementsView(viewModel: AchievementsViewModel())
}
