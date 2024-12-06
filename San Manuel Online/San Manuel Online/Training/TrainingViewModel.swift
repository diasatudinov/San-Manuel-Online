//
//  TrainingViewModel.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 05.12.2024.
//

import Foundation

class TrainingViewModel: ObservableObject  {
    
    var scenaries = [
        Scenario(amulets: [Amulet(imageName: "redMedal", color: "red"),Amulet(imageName: "greenMedal", color: "green"),Amulet(imageName: "greenMedal", color: "green"),Amulet(imageName: "yellowMedal", color: "yellow"),Amulet(imageName: "purpleMedal", color: "purple"),Amulet(imageName: "purpleMedal", color: "purple"), Amulet(imageName: "blueMedal", color: "blue"), Amulet(imageName: "yellowMedal", color: "yellow"),Amulet(imageName: "greenMedal", color: "green"),Amulet(imageName: "redMedal", color: "red"),Amulet(imageName: "greenMedal", color: "green"), Amulet(imageName: "blueMedal", color: "blue"), Amulet(imageName: "greenMedal", color: "green"),Amulet(imageName: "greenMedal", color: "green"),Amulet(imageName: "greenMedal", color: "green"),nil], score: 88),
        
        Scenario(
                amulets: [
                    Amulet(imageName: "redMedal", color: "red"),
                    Amulet(imageName: "redMedal", color: "red"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "redMedal", color: "red"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "redMedal", color: "red"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "redMedal", color: "red"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    nil
                ],
                score: 58
            ),
            // Scenario 3
            Scenario(
                amulets: [
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "redMedal", color: "red"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    nil
                ],
                score: 74
            ),
            // Scenario 4
            Scenario(
                amulets: [
                    nil,
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "redMedal", color: "red")
                ],
                score: 72
            ),
            // Scenario 5
            Scenario(
                amulets: [
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "yellowMedal", color: "yellow"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    Amulet(imageName: "blueMedal", color: "blue"),
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    nil,
                    Amulet(imageName: "orangeMedal", color: "orange"),
                    Amulet(imageName: "purpleMedal", color: "purple"),
                    nil,
                    Amulet(imageName: "greenMedal", color: "green"),
                    Amulet(imageName: "greenMedal", color: "green"),
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
        inventory = []
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
    
    func checkForWin(from index: Int) -> Bool {
        let gridSize = 4 // Размер сетки
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
}

struct Scenario {
    var id = UUID()
    var amulets: [Amulet?]
    var score: Int
}
