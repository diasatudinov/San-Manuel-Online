//
//  GameView.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 04.12.2024.
//

import SwiftUI
import AVFoundation


struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: GameViewModel
    @ObservedObject var achievementsVM: AchievementsViewModel
    @State private var audioPlayer: AVAudioPlayer?
    @ObservedObject var settingsVM: SettingsModel

    @State var selectedAmulet: Amulet?
    @State var selectedCell: Int?
    
    @State var playerTurn = true
    private let gridSize = 6
    
    
    @AppStorage("redAmuletCount") var redAmuletCount = 0
    
    var body: some View {
        ZStack {
            if viewModel.gameOn {
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize), spacing: 8) {
                        ForEach(Range(0...35)) { index in
                            ZStack {
                                Image(.cellBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 90:45)
                                    .onTapGesture {
                                        if playerTurn {
                                            handleCellTap(at: index)
                                        }
                                    }
                                
                                if let amulet = viewModel.cells[index] {
                                    Image(amulet.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 70:35)
                                        .background(viewModel.cells[index]?.owner == .ai ? Color.black : Color.clear)
                                        
                                }
                                
                            }
                        }
                        
                    }.frame(width: DeviceInfo.shared.deviceType == .pad ? 600:350)
                    
                    Spacer()
                    HStack {
                        ForEach(viewModel.inventory, id: \.self) { amulet in
                            if let index = viewModel.cells.firstIndex(where: { $0?.id == amulet.id }) {
                            } else {
                                Image(amulet.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:90)
                                    .padding(.bottom, DeviceInfo.shared.deviceType == .pad ? -90:-60)
                                    .offset(y: selectedAmulet == amulet ? -10 : 0)
                                    .onTapGesture {
                                        toggleAmuletSelection(amulet: amulet)
                                    }
                            }
                        }
                    }
                }.padding(.top, 20)
                
                VStack {
                    HStack {
                        VStack {
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
                        }
                        Spacer()
                        
                        VStack {
                            
                            TextWithBorder(text: "User score", font: .custom(Fonts.mazzardM.rawValue, size: 20), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                .textCase(.uppercase)
                            ZStack {
                                Image(.coinBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 45)
                                HStack(spacing: 0) {
                                   
                                    
                                    TextWithBorder(text: "\(viewModel.userScore)", font: .custom(Fonts.mazzardM.rawValue, size: 25), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                        .textCase(.uppercase)
                                }
                            }
                            
                            TextWithBorder(text: "AI score", font: .custom(Fonts.mazzardM.rawValue, size: 20), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                .textCase(.uppercase)
                            ZStack {
                                Image(.coinBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 45)
                                HStack(spacing: 0) {
                                   
                                    
                                    TextWithBorder(text: "\(viewModel.aiScore)", font: .custom(Fonts.mazzardM.rawValue, size: 25), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                        .textCase(.uppercase)
                                }
                            }
                            Spacer()
                        }
                    }.padding()
                    Spacer()
                }
            
            
            } else {
                VStack {
                    if DeviceInfo.shared.deviceType == .pad {
                        Spacer()
                    }
                    if viewModel.winner?.lowercased() == "player" {
                        TextWithBorder(text: "WIN!", font: .custom(Fonts.mazzardM.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 100 : 50), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                            .textCase(.uppercase)
                        
                        ZStack {
                            Image(.coinBg)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 90:45)
                            HStack(spacing: 0) {
                                
                                Image(.coin)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
                                
                                TextWithBorder(text: "+55 ", font: .custom(Fonts.mazzardM.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                    .textCase(.uppercase)
                            }
                        }.padding(.bottom)
                        
                        Button {
                            restart()
                        }label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 110:55, text: "NEXT", textSize: DeviceInfo.shared.deviceType == .pad ? 44:22)
                        }
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        }label: {
                            TextBg(type: .black, height: DeviceInfo.shared.deviceType == .pad ? 110:55, text: "HOME", textSize: DeviceInfo.shared.deviceType == .pad ? 44:22)
                        }
                        
                        Button {
                            restart()
                        }label: {
                            TextBg(type: .black, height: DeviceInfo.shared.deviceType == .pad ? 110:55, text: "RESTART", textSize: DeviceInfo.shared.deviceType == .pad ? 44:22)
                        }
                    } else {
                        TextWithBorder(text: "LOSE!", font: .custom(Fonts.mazzardM.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 100:50), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                            .textCase(.uppercase)
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        }label: {
                            TextBg(type: .black, height: DeviceInfo.shared.deviceType == .pad ? 110:55, text: "HOME", textSize: DeviceInfo.shared.deviceType == .pad ? 44:22)
                        }
                        
                        Button {
                            restart()
                        }label: {
                            TextBg(type: .black, height: DeviceInfo.shared.deviceType == .pad ? 110:55, text: "RESTART", textSize: DeviceInfo.shared.deviceType == .pad ? 44:22)
                        }
                    }
                    HStack {
                        Spacer()
                    }
                    if DeviceInfo.shared.deviceType == .pad {
                        Spacer()
                    }
                }
            }
            
        }.background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        .onChange(of: redAmuletCount) { newValue in
            if newValue > 49 { // 50
                achievementsVM.achievementTwoDone()
            }
            
        }
        .onChange(of: viewModel.winsCount) { newValue in
            if newValue > 9 {
                achievementsVM.achievementThreeDone()
            }
        }
        .onAppear {
            restart()
                
        }
    }
    
    // Toggle selection of an amulet
    private func toggleAmuletSelection(amulet: Amulet) {
        if selectedAmulet == amulet {
            selectedAmulet = nil
        } else {
            selectedAmulet = amulet
        }
    }
    
    // Handle placing an amulet in a cell
    private func handleCellTap(at index: Int) {
        guard let selectedAmulet = selectedAmulet, viewModel.cells[index] == nil else {
            return
        }
        
        // Player places their amulet
        viewModel.placeAmulet(amulet: selectedAmulet, at: index)
        switch selectedAmulet.color {
        case "red": viewModel.updateUserScore(points: 2)
            if redAmuletCount < 52 {
                redAmuletCount += 1
            }
        case "orange": viewModel.updateUserScore(points: 4)
        case "green": viewModel.updateUserScore(points: 6)
        case "yellow": viewModel.updateUserScore(points: 8)
        case "purple": viewModel.updateUserScore(points: 10)
        case "blue": viewModel.updateUserScore(points: 12)
            
        default:
            viewModel.updateUserScore(points: 2)
        }
         // Clear selection
        self.selectedAmulet = nil
        playerTurn = false
        if settingsVM.soundEnabled {
            playSound(named: "takeStar")
            
        }
        // Trigger AI's move
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            viewModel.aiMove()
            viewModel.checkGameEnd()
            playerTurn = true
            if settingsVM.soundEnabled {
                playSound(named: "takeStar")
                
            }
        }
        
       
    }
    
    private func restart() {
        
        if viewModel.winner?.lowercased() == "player" {
            if !viewModel.playerLose {
                viewModel.winsCount += 1
                print("WON")
            }
        }
        viewModel.winner = nil
        viewModel.cells = Array(repeating: nil, count: 36)
        viewModel.gameOn = true
        viewModel.userScore = 0
        viewModel.aiScore = 0
        viewModel.fillInventory()
        
        
    }
    
    func playSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel(), achievementsVM: AchievementsViewModel(), settingsVM: SettingsModel())
}
