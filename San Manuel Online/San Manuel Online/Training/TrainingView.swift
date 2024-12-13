//
//  TrainingView.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 05.12.2024.
//

import SwiftUI
import AVFoundation


struct TrainingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var audioPlayer: AVAudioPlayer?
    @ObservedObject var settingsVM: SettingsModel
    @ObservedObject var viewModel: TrainingViewModel
    @State var selectedAmulet: Amulet?
    @State var selectedCell: Int?
    @State var userScore = 0
    private let gridSize = 4
    var body: some View {
        ZStack {
            if userScore <= 100 {
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize), spacing: 8) {
                        ForEach(Range(0...15)) { index in
                            ZStack {
                                Image(.cellBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 130:65)
                                    .onTapGesture {
                                        handleCellTap(at: index)
                                        print("tapped at:", index)
                                    }
                                
                                if let amulet = viewModel.cells[index] {
                                    Image(amulet.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 110:55)
                                }
                                
                            }
                        }
                        
                    }.frame(width: DeviceInfo.shared.deviceType == .pad ? 550:350)
                    
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
                                    .offset(y: selectedAmulet == amulet ? -10 : 0) // Highlight selected amulet
                                    .onTapGesture {
                                        toggleAmuletSelection(amulet: amulet)
                                    }
                            }
                        }
                    }
                }.padding(.top, 20)
                
                VStack {
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
                        VStack {
                            
                            TextWithBorder(text: "Score", font: .custom(Fonts.mazzardM.rawValue, size: 25), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                .textCase(.uppercase)
                            ZStack {
                                Image(.coinBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 45)
                                HStack(spacing: 0) {
                                   
                                    
                                    TextWithBorder(text: "\(userScore)", font: .custom(Fonts.mazzardM.rawValue, size: 25), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                        .textCase(.uppercase)
                                }
                            }
                        }
                    }.padding()
                    Spacer()
                }
                
            } else {
                VStack {
                    Spacer()
                    TextWithBorder(text: "WIN!", font: .custom(Fonts.mazzardM.rawValue, size: 50), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                        .textCase(.uppercase)
                    
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
                            
                            TextWithBorder(text: "+1 ", font: .custom(Fonts.mazzardM.rawValue, size: 20), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                .textCase(.uppercase)
                        }
                    }.padding(.bottom)
                    
                    Button {
                        restart()
                    }label: {
                        TextBg(height: 55, text: "NEXT", textSize: 22)
                    }
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        TextBg(type: .black, height: 55, text: "HOME", textSize: 22)
                    }
                    
                    Button {
                        restart()
                    }label: {
                        TextBg(type: .black, height: 55, text: "RESTART", textSize: 22)
                    }
                    HStack {
                        Spacer()
                    }
                    Spacer()
                }
            }
            
        }
        .onAppear {
            restart()
        }
        .background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
    
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
            return // Do nothing if no amulet selected or cell is occupied
        }
        
        // Player places their amulet
        viewModel.placeAmulet(amulet: selectedAmulet, at: index)
        
        if viewModel.checkForWin(from: index) {
            userScore = 101
            User.shared.updateUserCoins(for: 1)
        }
        
        switch selectedAmulet.color {
        case "red": userScore += 2
        case "orange": userScore += 4
        case "green": userScore += 6
        case "yellow": userScore += 8
        case "purple": userScore += 10
        case "blue": userScore += 12
            
        default:
            userScore += 2
        }
        // Clear selection
        self.selectedAmulet = nil
        if settingsVM.soundEnabled {
            playSound(named: "takeStar")
            
        }
        
    }
    func fetchScenario() {
        let index = Int.random(in: 0...viewModel.scenaries.count - 1)
        viewModel.cells = viewModel.scenaries[index].amulets
        userScore = viewModel.scenaries[index].score
    }
    
    private func restart() {
        fetchScenario()
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
    TrainingView(settingsVM: SettingsModel(), viewModel: TrainingViewModel())
}
