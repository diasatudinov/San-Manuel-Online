//
//  GameViewModel.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 04.12.2024.
//

import SwiftUI

enum OwnerType: Codable {
    case player
    case ai
}

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
    @Published var gameOn = true
    
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
        if let inventoryIndex = inventory.firstIndex(where: { $0.id == amulet.id }) {
            let randomAmulet = amulets.randomElement()!
            
            let amulet = Amulet(imageName: randomAmulet.imageName, color: randomAmulet.color)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.inventory[inventoryIndex] = amulet
            }
        }
        
        
        if checkForWin(from: index) {
            gameOn = false
            winner = "PLAYER"
            User.shared.updateUserCoins(for: 55)
        }
        
        checkGameEnd()
        
    }
    
    func aiMove() {
        // Find all empty cells
        let emptyCells = cells.enumerated().filter { $0.element == nil }.map { $0.offset }
        guard !emptyCells.isEmpty else { return } // No moves possible
        
        // Pick a random empty cell
        let randomCell = emptyCells.randomElement()!
                
        
        // Place the AI amulet in the selected cell
        if var randomAmulet = inventory.randomElement() {
            randomAmulet.owner = .ai
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
    
    func checkGameEnd() {
        guard winner == nil else { return }
        if userScore >= 100 {
            gameOn = false
            winner = "PLAYER"
            User.shared.updateUserCoins(for: 55)
        }
        
        if aiScore >= 100 {
            gameOn = false
            winner = "AI"
        }
        
        let emptyCells = cells.enumerated().filter { $0.element == nil }.map { $0.offset }
        
        if emptyCells.isEmpty {
            gameOn = false
            winner = "AI"
        }
        
        
    }

    func checkForWin(from index: Int) -> Bool {
        let gridSize = 6 // Размер сетки
        let row = index / gridSize // Номер строки
        let col = index % gridSize // Номер столбца

        // Функция для проверки направления
        func checkDirection(deltaRow: Int, deltaCol: Int) -> Bool {
            var amulets: [Amulet] = [] // Массив для хранения амулетов в направлении

            // Проверяем клетки в пределах 3 шагов в обе стороны
            for step in -3...3 {
                let newRow = row + step * deltaRow
                let newCol = col + step * deltaCol
                let newIndex = newRow * gridSize + newCol

                // Убедимся, что координаты в пределах сетки
                if newRow >= 0, newRow < gridSize, newCol >= 0, newCol < gridSize {
                    if let amulet = cells[newIndex] {
                        amulets.append(amulet)
                    } else {
                        amulets.append(Amulet(imageName: "", color: "", owner: .player)) // Пустая клетка
                    }
                }
            }

            // Ищем 4 подряд одинаковых цвета и владельца
            var consecutiveCount = 0
            var lastAmulet: Amulet? = nil

            for amulet in amulets {
                if let last = lastAmulet, last.color == amulet.color && last.owner == amulet.owner {
                    consecutiveCount += 1
                    if consecutiveCount == 4 { return true } // Найдено совпадение
                } else {
                    consecutiveCount = 1
                    lastAmulet = amulet
                }
            }
            return false
        }

        // Проверяем все направления
        return checkDirection(deltaRow: 0, deltaCol: 1) ||  // Горизонталь
               checkDirection(deltaRow: 1, deltaCol: 0) ||  // Вертикаль
               checkDirection(deltaRow: 1, deltaCol: 1) ||  // Диагональ вниз-вправо
               checkDirection(deltaRow: 1, deltaCol: -1)    // Диагональ вниз-влево
    }
    
    //Correct One
    
//    func checkForWin(from index: Int) -> Bool {
//        let gridSize = 6 // Размер сетки
//        let row = index / gridSize // Номер строки
//        let col = index % gridSize // Номер столбца
//
//        // Функция для проверки направления
//        func checkDirection(deltaRow: Int, deltaCol: Int) -> Bool {
//            var colors: [String] = []
//
//            for step in -3...3 { // Проверяем клетки в пределах 3 шагов в обе стороны
//                let newRow = row + step * deltaRow
//                let newCol = col + step * deltaCol
//                let newIndex = newRow * gridSize + newCol
//
//                // Убедимся, что координаты в пределах сетки
//                if newRow >= 0, newRow < gridSize, newCol >= 0, newCol < gridSize {
//                    if let amulet = cells[newIndex] {
//                        colors.append(amulet.color)
//                    } else {
//                        colors.append("") // Пустая клетка
//                    }
//                }
//            }
//
//            // Ищем 4 подряд одинаковых цвета
//            var consecutiveCount = 0
//            var lastColor = ""
//            for color in colors {
//                if color == lastColor && color != "" {
//                    consecutiveCount += 1
//                    if consecutiveCount == 4 { return true } // Найдено совпадение
//                } else {
//                    consecutiveCount = 1
//                    lastColor = color
//                }
//            }
//            return false
//        }
//
//        // Проверяем все направления
//        return checkDirection(deltaRow: 0, deltaCol: 1) ||  // Горизонталь
//               checkDirection(deltaRow: 1, deltaCol: 0) ||  // Вертикаль
//               checkDirection(deltaRow: 1, deltaCol: 1) ||  // Диагональ вниз-вправо
//               checkDirection(deltaRow: 1, deltaCol: -1)    // Диагональ вниз-влево
//    }
}
