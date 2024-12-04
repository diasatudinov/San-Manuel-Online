//
//  GameViewModel.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 04.12.2024.
//

import SwiftUI

class GameViewModel: ObservableObject {
    
    var amulets: [Amulet] = [
        Amulet(imageName: "redMedal", color: "red"),
        Amulet(imageName: "orangeMedal", color: "orange"),
        Amulet(imageName: "greenMedal", color: "green"),
        Amulet(imageName: "yellowMedal", color: "yellow"),
        Amulet(imageName: "purpleMedal", color: "purple"),
        Amulet(imageName: "blueMedal", color: "blue")
        
    ]
    
    private var aiAmulets: [Amulet] = [
            Amulet(imageName: "amuletAI", color: "redAI"),
            Amulet(imageName: "amuletAI", color: "orangeAI"),
            Amulet(imageName: "amuletAI", color: "greenAI"),
            Amulet(imageName: "amuletAI", color: "yellowAI"),
            Amulet(imageName: "amuletAI", color: "purpleAI"),
            Amulet(imageName: "amuletAI", color: "blueAI")
        ]
    
    @Published var inventory: [Amulet] = []
    @Published var cells: [Amulet?] = Array(repeating: nil, count: 36)
    
    @Published var userScore: Int = 0
    @Published var aiScore: Int = 0
    
    @Published var winner: String?
    
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
    
    func updateUserScore(points: Int) {
        userScore += points
    }
    func placeAmulet(amulet: Amulet, at index: Int) {
        cells[index] = amulet // Place amulet in the grid cell
        
        // Replace the amulet in the inventory
        if let inventoryIndex = inventory.firstIndex(of: amulet) {
            let amulet = Amulet(imageName: amulets.randomElement()!.imageName, color: amulets.randomElement()!.color)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.inventory[inventoryIndex] = amulet
            }
        }
        
        checkWinCondition()
    }
    
    func aiMove() {
        // Find all empty cells
        let emptyCells = cells.enumerated().filter { $0.element == nil }.map { $0.offset }
        guard !emptyCells.isEmpty else { return } // No moves possible
        
        // Pick a random empty cell
        let randomCell = emptyCells.randomElement()!
                
        
        // Place the AI amulet in the selected cell
        if let randomAmulet = inventory.randomElement() {
            placeAmulet(amulet: randomAmulet, at: randomCell)
            switch randomAmulet.color {
            case "red": aiScore += 2
            case "orange": aiScore += 4
            case "green": aiScore += 6
            case "yellow": aiScore += 8
            case "purple": aiScore += 10
            case "blue": aiScore += 12
                
            default:
                aiScore += 2
            }
        }
    }
    
    private func checkWinCondition() {
        let directions = [
            (dx: 1, dy: 0),   // Horizontal
            (dx: 0, dy: 1),   // Vertical
            (dx: 1, dy: 1),   // Diagonal \
            (dx: 1, dy: -1)   // Diagonal /
        ]
        
        let gridSize = 6 // Size of the grid
        
        for y in 0..<gridSize {
            for x in 0..<gridSize {
                guard let currentAmulet = cells[y * gridSize + x] else { continue }
                
                for direction in directions {
                    if isWinningLine(startX: x, startY: y, dx: direction.dx, dy: direction.dy, color: currentAmulet.color, gridSize: gridSize) {
                        winner = currentAmulet.color // Set the winner as the amulet's color
                        return
                    }
                }
            }
        }
    }
    
    private func isWinningLine(startX: Int, startY: Int, dx: Int, dy: Int, color: String, gridSize: Int) -> Bool {
        var count = 0
        
        for i in 0..<5 { // Check up to 4 cells in the given direction
            let newX = startX + i * dx
            let newY = startY + i * dy
            
            if newX < 0 || newY < 0 || newX >= gridSize || newY >= gridSize {
                return false // Out of bounds
            }
            
            if cells[newY * gridSize + newX]?.color == color {
                count += 1
            } else {
                break
            }
        }
        
        return count == 4
    }
}
