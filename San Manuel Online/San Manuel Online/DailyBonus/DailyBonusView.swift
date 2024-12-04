//
//  DailyBonusView.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 03.12.2024.
//

import SwiftUI

struct DailyBonusView: View {
    @StateObject var user = User.shared
    @Environment(\.presentationMode) var presentationMode
    
    @State private var bonusPoints: Int? = nil // To display the bonus points after button press
    @State private var lastPressDate: Date? = nil // Track the last press date
    @State private var isButtonDisabled: Bool = false // Disable button logic
    
    @State private var boxStates = [false, false, false] // Track if each box is opened
    @State private var boxBonuses = [Int?](repeating: nil, count: 3) // Track random bonus for each box
    @State private var savedBonus = 0
    @State private var oneBoxOpened = false
    let possibleBonuses = [10, 25, 50]
    var body: some View {
        ZStack {
            
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        TextWithBorder(text: "Daily Bonus", font: .custom(Fonts.mazzardM.rawValue, size: 55), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
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
                
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { index in
                        Button(action: {
                            openBox(at: index)
                        }) {
                            ZStack {
                                Image(boxStates[index] ? "openedBox" : "closedBox")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: boxStates[index] ? 180 : 180)
                                    .padding(.horizontal, 20)
                                
                                if boxStates[index] {
                                    Image(.yellowBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                    HStack {
                                        Image(.coin)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 40)
                                        
                                        TextWithBorder(text: "+ \(savedBonus)", font: .custom(Fonts.mazzardM.rawValue, size: 25), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                            .textCase(.uppercase)
                                        
                                    }
                                }
                                
                            }
                        }
                        .disabled(oneBoxOpened)
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            checkButtonState()
        }
        .background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
    
    // Handle button press logic
    private func handleButtonPress(point: Int) {
        user.updateUserCoins(for: point)
        lastPressDate = Date() // Update last press date
        UserDefaults.standard.set(lastPressDate, forKey: "LastPressDate")
        UserDefaults.standard.set(boxStates, forKey: "boxStates")
        UserDefaults.standard.set(savedBonus, forKey: "savedBonus")
        
        isButtonDisabled = true // Disable button
        
        // Optionally refresh button state after 24 hours
        DispatchQueue.main.asyncAfter(deadline: .now() + 24 * 60 * 60) {
            checkButtonState()
        }
    }
    
    // Check if button can be pressed
    private func checkButtonState() {
        if let boxStates = UserDefaults.standard.object(forKey: "boxStates") as? [Bool] {
            
            self.boxStates = boxStates
            
        }
        
        if let savedBonus = UserDefaults.standard.object(forKey: "savedBonus") as? Int {
            self.savedBonus = savedBonus
        }
        if let savedDate = UserDefaults.standard.object(forKey: "LastPressDate") as? Date {
            let elapsedTime = Date().timeIntervalSince(savedDate)
            if elapsedTime >= 24 * 60 * 60 {
                isButtonDisabled = false // Re-enable button
                oneBoxOpened = false
                boxStates = [false, false, false]
            } else {
                isButtonDisabled = true
                oneBoxOpened = true
            }
        }
        
        
    }
    
    // Open a box
    private func openBox(at index: Int) {
        guard !oneBoxOpened else { return } // Prevent reopening
        oneBoxOpened = true
        boxStates[index] = true // Mark the box as opened
        boxBonuses[index] = possibleBonuses.randomElement() // Assign a random bonus
        savedBonus = boxBonuses[index] ?? 0
        handleButtonPress(point: boxBonuses[index] ?? 0)
    }
}

#Preview {
    DailyBonusView()
}
