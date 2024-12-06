//
//  GameView.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 04.12.2024.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: GameViewModel
    @State var selectedAmulet: Amulet?
    @State var selectedCell: Int?
    
    @State var playerTurn = true
    private let gridSize = 6
    
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
                                    .frame(height: 45)
                                    .onTapGesture {
                                        if playerTurn {
                                            handleCellTap(at: index)
                                        }
                                    }
                                
                                if let amulet = viewModel.cells[index] {
                                    Image(amulet.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 35)
                                        .background(viewModel.cells[index]?.owner == .ai ? Color.black : Color.clear)
                                        
                                }
                                
                            }
                        }
                        
                    }.frame(width: 350)
                    
                    Spacer()
                    HStack {
                        ForEach(viewModel.inventory, id: \.self) { amulet in
                            if let index = viewModel.cells.firstIndex(where: { $0?.id == amulet.id }) {
                            } else {
                                Image(amulet.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 90)
                                    .padding(.bottom, -60)
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
                    if viewModel.winner?.lowercased() == "player" {
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
                                
                                TextWithBorder(text: "+55 ", font: .custom(Fonts.mazzardM.rawValue, size: 20), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
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
                    } else {
                        TextWithBorder(text: "LOSE!", font: .custom(Fonts.mazzardM.rawValue, size: 50), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                            .textCase(.uppercase)
                        
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
                    }
                    HStack {
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
        
        // Trigger AI's move
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            viewModel.aiMove()
            viewModel.checkGameEnd()
            playerTurn = true
            
        }
        
       
    }
    
    private func restart() {
        viewModel.winner = nil
        viewModel.cells = Array(repeating: nil, count: 36)
        viewModel.gameOn = true
        viewModel.userScore = 0
        viewModel.aiScore = 0
        
    }
}

#Preview {
    GameView(viewModel: GameViewModel())
}
