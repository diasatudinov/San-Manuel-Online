//
//  Menu.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 03.12.2024.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showPlay = false
    @State private var showTraining = false
    @State private var showAchievements = false
    @State private var showDailyBonus = false
    @State private var showSettings = false
    @State private var showHowToPlay = false
    
    @StateObject var user = User.shared
    //@StateObject var achievementsVM = AchievementsViewModel()
    //    @StateObject var leaderboardVM = LeaderboardViewModel()
//      @StateObject var settingsVM = SettingsModel()
//    @StateObject var collectionVM = CollectionViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                if geometry.size.width < geometry.size.height {
                    // Вертикальная ориентация
                    ZStack {
                        VStack {
                            HStack(spacing: 5){
                                ZStack {
                                    Image(.coinBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 55)
                                    HStack(spacing: 0) {
                                        
                                        Image(.coin)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 40)
                                        
                                        TextWithBorder(text: "\(user.coins) ", font: .custom(Fonts.mazzardM.rawValue, size: 25), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                            .textCase(.uppercase)
                                       
                                            
                                    }
                                }
                                
                            }
                            Spacer()
                        }.padding()
                        
                        HStack {
                            Spacer()
                            VStack(spacing: 20) {
                                
                                Button {
                                    showPlay = true
                                } label: {
                                    TextBg(height: 75, text: "Play", textSize: 35)
                                }
                                
                                Button {
                                    showTraining = true
                                } label: {
                                    TextBg(height: 75, text: "Training", textSize: 35)
                                }
                                
                                Button {
                                    showSettings = true
                                } label: {
                                    TextBg(height: 75, text: "Settings", textSize: 35)
                                }
                                
                                Button {
                                    showAchievements = true
                                } label: {
                                    TextBg(height: 75, text: "Achievements", textSize: 30)
                                }
                                
                                Button {
                                    showDailyBonus = true
                                } label: {
                                    TextBg(height: 75, text: "Daily Bonus", textSize: 35)
                                }
                                
                                Button {
                                    showHowToPlay = true
                                } label: {
                                    TextBg(height: 75, text: "How to play", textSize: 35)
                                }
                                
                            }
                            Spacer()
                        }
                    }
                } else {
                    ZStack {
                        
                        VStack {
                            HStack(spacing: 5){
                                ZStack {
                                    Image(.coinBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 45)
                                    HStack(spacing: 0) {
                                        
                                        Image(.coin)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 30)
                                        
                                        TextWithBorder(text: "\(user.coins) ", font: .custom(Fonts.mazzardM.rawValue, size: 20), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                            .textCase(.uppercase)
                                       
                                            
                                    }
                                }
                                
                            }.padding([.top, .trailing], 20)
                            Spacer()
                        }
                        
                        VStack {
                            Spacer()
                            VStack(spacing: 10) {
                                Spacer()
                                
                                HStack {
                                    Button {
                                        showPlay = true
                                    } label: {
                                        TextBg(height: 65, text: "Play", textSize: 35)
                                    }
                                }
                                HStack(spacing: 15) {
                                    Spacer()
                                    Button {
                                        showTraining = true
                                    } label: {
                                        TextBg(height: 65, text: "Training", textSize: 35)
                                    }
                                    
                                    Button {
                                        showSettings = true
                                    } label: {
                                        TextBg(height: 65, text: "Settings", textSize: 35)
                                    }
                                    Spacer()
                                }
                                
                                HStack(spacing: 15) {
                                    Spacer()
                                    Button {
                                        showAchievements = true
                                    } label: {
                                        TextBg(height: 65, text: "Achievements", textSize: 25)
                                    }
                                    
                                    Button {
                                        showDailyBonus = true
                                    } label: {
                                        TextBg(height: 65, text: "Daily Bonus", textSize: 35)
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Button {
                                        showHowToPlay = true
                                    } label: {
                                        TextBg(height: 65, text: "How to play", textSize: 30)
                                    }
                                    Spacer()
                                }
                                
                            }
                        }
                        
                        
                    }
                }
            }
            .background(
                Image(.background)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                
            )
//            .onAppear {
//                if settingsVM.musicEnabled {
//                    MusicPlayer.shared.playBackgroundMusic()
//                }
//            }
//            .onChange(of: settingsVM.musicEnabled) { enabled in
//                if enabled {
//                    MusicPlayer.shared.playBackgroundMusic()
//                } else {
//                    MusicPlayer.shared.stopBackgroundMusic()
//                }
//            }
            .fullScreenCover(isPresented: $showPlay) {
               // TrainGameView(settingsVM: settingsVM)
            }
            .fullScreenCover(isPresented: $showTraining) {
              //  SequenceGameView(settingsVM: settingsVM)
            }
            .fullScreenCover(isPresented: $showSettings) {
               // GetCardView(collectionVM: collectionVM)
            }
            .fullScreenCover(isPresented: $showAchievements) {
               // CollectionView(collectionVM: collectionVM)
            }
            .fullScreenCover(isPresented: $showDailyBonus) {
               // SettingsView(settings: settingsVM)
            }
            .fullScreenCover(isPresented: $showHowToPlay) {
               // SettingsView(settings: settingsVM)
            }
            
        }
    }
}

#Preview {
    MenuView()
}
