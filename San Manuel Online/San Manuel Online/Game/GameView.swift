//
//  GameView.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 04.12.2024.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var cards: [String] = []
    @ObservedObject var viewModel: GameViewModel
    @State var selectedAmulet: Amulet?
    @State var selectedCell: Int?
    private let gridSize = 6
    var body: some View {
        ZStack {
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize), spacing: 8) {
                    ForEach(Range(0...35)) { index in
                        ZStack {
                            Image(.cellBg)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 45)
                                .onTapGesture {
                                    handleCellTap(at: index)
                                }
                            
                            if let amulet = viewModel.cells[index] {
                                Image(amulet.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 35)
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
                        Text("USER SCORE: \(viewModel.userScore)")
                        Text("AI SCORE: \(viewModel.aiScore)")
                        
                        if let winner = viewModel.winner {
                            Text(winner)
                        }
                    }
                }.padding()
                Spacer()
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
            return // Do nothing if no amulet selected or cell is occupied
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
        self.selectedAmulet = nil // Clear selection
        
        // Trigger AI's move
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //viewModel.aiMove()
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel())
}
