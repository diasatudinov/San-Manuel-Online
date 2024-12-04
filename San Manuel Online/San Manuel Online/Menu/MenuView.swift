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
    @StateObject var achievementsVM = AchievementsViewModel()
    //    @StateObject var leaderboardVM = LeaderboardViewModel()
      @StateObject var settingsVM = SettingsModel()
//    @StateObject var collectionVM = CollectionViewModel()
    
    
    @State private var timeRemaining: String = "24:00"
    @State private var timerActive: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                                    
                                    ZStack {
                                    TextBg(height: 75, text: "Daily Bonus", textSize: 35)
                                        TextWithBorder(text: "\(timeRemaining)", font: .custom(Fonts.mazzardM.rawValue, size: 16), textColor: .mainBrown, borderColor: .mainYellow, borderWidth: 1)
                                            .offset(x: 95, y: -15)
                                            
                                    }
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
                                Spacer()
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
                                Spacer()
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
                                        TextBg(height: 65, text: "Play", textSize: 32)
                                    }
                                }
                                HStack(spacing: 15) {
                                    Spacer()
                                    Button {
                                        showTraining = true
                                    } label: {
                                        TextBg(height: 65, text: "Training", textSize: 32)
                                    }
                                    
                                    Button {
                                        showSettings = true
                                    } label: {
                                        TextBg(height: 65, text: "Settings", textSize: 32)
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
                                        ZStack {
                                            TextBg(height: 65, text: "Daily Bonus", textSize: 27)
                                            TextWithBorder(text: "\(timeRemaining)", font: .custom(Fonts.mazzardM.rawValue, size: 16), textColor: .mainBrown, borderColor: .mainYellow, borderWidth: 1)
                                                .offset(x: 75, y: -15)
                                                
                                        }
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Button {
                                        showHowToPlay = true
                                    } label: {
                                        TextBg(height: 65, text: "How to play", textSize: 27)
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
            .onAppear {
                updateTimer()
            }
            .onReceive(timer) { _ in
                updateTimer()
            }
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
                SettingsView(settings: settingsVM)
            }
            .fullScreenCover(isPresented: $showTraining) {
                SettingsView(settings: settingsVM)
            }
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView(settings: settingsVM)
            }
            .fullScreenCover(isPresented: $showAchievements) {
                AchievementsView(viewModel: achievementsVM)
            }
            .fullScreenCover(isPresented: $showDailyBonus) {
                DailyBonusView()
            }
            .fullScreenCover(isPresented: $showHowToPlay) {
                RulesView()
            }
            
        }
    }
    
    private func updateTimer() {
        guard let lastPressDate = UserDefaults.standard.object(forKey: "LastPressDate") as? Date else {
            timeRemaining = "00:00" // If no saved date, assume timer is full
            timerActive = false
            return
        }
        
        let now = Date()
        let totalDuration: TimeInterval = 24 * 60 * 60 // 24 hours in seconds
        let elapsedTime = now.timeIntervalSince(lastPressDate) // Time since lastPressDate
        let remainingTime = totalDuration - elapsedTime // Time left
        
        if remainingTime <= 0 {
            timeRemaining = "00:00"
            timerActive = false
        } else {
            timerActive = true
            let hours = Int(remainingTime) / 3600
            let minutes = (Int(remainingTime) % 3600) / 60
            timeRemaining = String(format: "%02d:%02d", hours, minutes) // Format as hh:mm
        }
    }
}

#Preview {
    MenuView()
}
