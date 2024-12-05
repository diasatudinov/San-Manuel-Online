//
//  TrainingViewModel.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 05.12.2024.
//

import Foundation

class TrainingViewModel: ObservableObject  {
    
    var scenaries = [
        Scenario(amulets: [Amulet(imageName: "redMedal", color: "red"),Amulet(imageName: "greenMedal", color: "green"),Amulet(imageName: "greenMedal", color: "green"),Amulet(imageName: "yellowMedal", color: "yellow"),Amulet(imageName: "purpleMedal", color: "purple"),Amulet(imageName: "purpleMedal", color: "purple"), Amulet(imageName: "blueMedal", color: "blue"), Amulet(imageName: "yellowMedal", color: "yellow"),Amulet(imageName: "greenMedal", color: "green"),Amulet(imageName: "redMedal", color: "red"),Amulet(imageName: "greenMedal", color: "green"), Amulet(imageName: "blueMedal", color: "blue"), nil,nil,nil,nil], score: 88),
        
        Scenario(
                amulets: [
                    nil,
                    Amulet(imageName: "redMedal", color: "red"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    nil,
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    nil,
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    nil,
                    nil,
                    nil,
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "redMedal", color: "red"),
                    nil,
                    nil
                ],
                score: 58
            ),
            // Scenario 3
            Scenario(
                amulets: [
                    Amulet(imageName: "blueMedal", color: "blue"),
                    nil,
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    nil,
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "redMedal", color: "red"),
                    nil,
                    Amulet(imageName: "blueMedal", color: "blue"),
                    nil,
                    nil,
                    Amulet(imageName: "greenMedal", color: "green"),
                    nil,
                    nil,
                    Amulet(imageName: "purpleMedal", color: "purple")
                ],
                score: 74
            ),
            // Scenario 4
            Scenario(
                amulets: [
                    nil,
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "redMedal", color: "red"),
                    nil,
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    nil,
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    nil,
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    nil,
                    nil,
                    Amulet(imageName: "blueMedal", color: "blue"),
                    nil,
                    Amulet(imageName: "redMedal", color: "red")
                ],
                score: 72
            ),
            // Scenario 5
            Scenario(
                amulets: [
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    nil,
                    nil,
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    nil,
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "redMedal", color: "red"),
                    nil,
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    nil,
                    nil,
                    nil,
                    Amulet(imageName: "greenMedal", color: "green")
                ],
                score: 68
            )
        
    ]
    
    
    var amulets: [Amulet] = [
        Amulet(imageName: "redMedal", color: "red"),
        Amulet(imageName: "orangeMedal", color: "orange"),
        Amulet(imageName: "greenMedal", color: "green"),
        Amulet(imageName: "yellowMedal", color: "yellow"),
        Amulet(imageName: "purpleMedal", color: "purple"),
        Amulet(imageName: "blueMedal", color: "blue")
        
    ]
    
    
    @Published var inventory: [Amulet] = []
    @Published var cells: [Amulet?] = Array(repeating: nil, count: 16)
    
    init() {
        fillInventory()
    }
    
    func fillInventory() {
        
        for amulet in amulets.shuffled() {
            let amulet = Amulet(imageName: amulet.imageName, color: amulet.color)
            inventory.append(amulet)
        }
        inventory.prefix(6)
    }
    
    func placeAmulet(amulet: Amulet, at index: Int) {
        cells[index] = amulet // Place amulet in the grid cell
        
        // Replace the amulet in the inventory
        if let inventoryIndex = inventory.firstIndex(of: amulet) {
            let randomAmulet = amulets.randomElement()!
            
            let amulet = Amulet(imageName: randomAmulet.imageName, color: randomAmulet.color)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.inventory[inventoryIndex] = amulet
            }
        }
        
    }
}

struct Scenario {
    var id = UUID()
    var amulets: [Amulet?]
    var score: Int
}
