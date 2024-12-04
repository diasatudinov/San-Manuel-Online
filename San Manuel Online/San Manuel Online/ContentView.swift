//
//  ContentView.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 02.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var grid = Array(repeating: Array(repeating: "", count: 5), count: 5)
    @State private var inventory = ["Red", "Blue", "Green", "Yellow", "Purple", "Orange"]

    var body: some View {
        VStack {
            // Game Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                ForEach(0..<25, id: \.self) { index in
                    let x = index / 5
                    let y = index % 5
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 60)
                        Text(grid[x][y])
                            .foregroundColor(.black)
                    }
                    .onDrop(of: ["public.text"], isTargeted: nil) { providers in
                        providers.first?.loadObject(ofClass: String.self) { amulet, _ in
                            if let amulet = amulet as? String {
                                grid[x][y] = amulet
                                inventory.removeAll { $0 == amulet }
                                inventory.append(generateNewAmulet())
                                performOpponentMove()
                            }
                        }
                        return true
                    }
                }
            }

            // Inventory
            HStack {
                ForEach(inventory, id: \.self) { amulet in
                    Text(amulet)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .onDrag {
                            NSItemProvider(object: amulet as NSString)
                        }
                }
            }
        }
        .padding()
    }

    func generateNewAmulet() -> String {
        ["Red", "Blue", "Green", "Yellow", "Purple", "Orange"].randomElement()!
    }

    func performOpponentMove() {
        // Simple AI logic here
    }
}

//struct GameView: View {
//    // Размер игрового поля
//    let gridSize = 6
//    
//    // Состояние ячеек игрового поля
//    @State private var gameGrid: [[Cell]] = {
//        let row = Array(repeating: Cell(), count: 6)
//        return Array(repeating: row, count: 6)
//    }()
//    
//    // Инвентарь игрока
//    @State private var playerInventory: [Amulet] = Amulet.generateRandomInventory()
//    
//    // Очки игроков
//    @State private var playerScore = 0
//    @State private var aiScore = 0
//    
//    // Текущий игрок
//    @State private var isPlayerTurn = true
//    
//    var body: some View {
//        VStack {
//            // Счет
//            HStack {
//                Text("Player: \(playerScore) pts")
//                Spacer()
//                Text("AI: \(aiScore) pts")
//            }
//            .padding()
////            
////            // Игровое поле
////            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize), spacing: 5) {
////                ForEach(0..<gridSize, id: \.self) { row in
////                    ForEach(0..<gridSize, id: \.self) { col in
////                        CellView(cell: $gameGrid[row][col])
////                            .onDrop(of: [.text], isTargeted: nil) { providers -> Bool in
////                                guard let amuletData = providers.first?.loadItem(forTypeIdentifier: "public.text", options: nil, completionHandler: nil),
////                                      let amuletID = String(data: amuletData as! Data, encoding: .utf8),
////                                      let amulet = Amulet(id: UUID(uuidString: amuletID)) else { return false }
////                                
////                                return handlePlayerMove(amulet: amulet, row: row, col: col)
////                            }
////                    }
////                }
////            }
////            .padding()
////            
////            // Инвентарь игрока
//            HStack {
//                ForEach(playerInventory) { amulet in
//                    DraggableAmuletView(amulet: amulet)
//                }
//            }
//            .padding()
//        }
//        .onChange(of: isPlayerTurn) { _ in
//            if !isPlayerTurn {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    aiMove()
//                }
//            }
//        }
//    }
//    
//    // Обработка хода игрока
//    private func handlePlayerMove(amulet: Amulet, row: Int, col: Int) -> Bool {
//        guard gameGrid[row][col].amulet == nil else { return false }
//        
//        gameGrid[row][col].amulet = amulet
//        playerInventory.removeAll { $0.id == amulet.id }
//        playerInventory.append(Amulet.random())
//        
//        updateScores(for: amulet, player: true)
//        isPlayerTurn = false
//        
//        return true
//    }
//    
//    // Логика хода ИИ
//    private func aiMove() {
//        guard let move = findBestMove() else { return }
//        gameGrid[move.row][move.col].amulet = Amulet.randomAIAmulet()
//        updateScores(for: gameGrid[move.row][move.col].amulet!, player: false)
//        isPlayerTurn = true
//    }
//    
//    // Поиск лучшего хода для ИИ
//    private func findBestMove() -> (row: Int, col: Int)? {
//        for row in 0..<gridSize {
//            for col in 0..<gridSize {
//                if gameGrid[row][col].amulet == nil {
//                    return (row, col)
//                }
//            }
//        }
//        return nil
//    }
//    
//    // Обновление очков
//    private func updateScores(for amulet: Amulet, player: Bool) {
//        switch amulet.type {
//        case .red:
//            if player {
//                playerScore += 5
//            } else {
//                aiScore += 5
//            }
//        case .blue:
//            // Блокировка следующего хода ИИ
//            break
//        case .green:
//            if player {
//                isPlayerTurn = true
//            }
//        }
//    }
//}
//
//struct CellView: View {
//    @Binding var cell: Cell
//    
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(cell.amulet == nil ? Color.gray.opacity(0.2) : cell.amulet!.color)
//                .aspectRatio(1, contentMode: .fit)
//                .cornerRadius(5)
//            
//            if let amulet = cell.amulet {
//                Text(amulet.type.rawValue)
//                    .font(.title)
//                    .foregroundColor(.white)
//            }
//        }
//    }
//}
//
//struct DraggableAmuletView: View {
//    let amulet: Amulet
//    
//    var body: some View {
//        Text(amulet.type.rawValue)
//            .padding()
//            .background(amulet.color)
//            .cornerRadius(5)
//            .foregroundColor(.white)
//            .onDrag {
//                NSItemProvider(object: amulet.id.uuidString as NSString)
//            }
//    }
//}
//
//// Модель ячейки
//struct Cell {
//    var amulet: Amulet? = nil
//}
//
//// Типы амулетов
//struct Amulet: Identifiable {
//    let id = UUID()
//    let type: AmuletType
//    let color: Color
//    
//    static func random() -> Amulet {
//        let types: [AmuletType] = [.red, .blue, .green]
//        let type = types.randomElement()!
//        return Amulet(type: type, color: type.color)
//    }
//    
//    static func generateRandomInventory() -> [Amulet] {
//        (0..<6).map { _ in random() }
//    }
//    
//    static func randomAIAmulet() -> Amulet {
//        random()
//    }
//}
//
//enum AmuletType: String {
//    case red = "R"
//    case blue = "B"
//    case green = "G"
//    
//    var color: Color {
//        switch self {
//        case .red: return .red
//        case .blue: return .blue
//        case .green: return .green
//        }
//    }
//}
//
//struct ContentView1: View {
//    @State private var bonusPoints: Int? = nil // To display the bonus points after button press
//    @State private var lastPressDate: Date? = nil // Track the last press date
//    @State private var isButtonDisabled: Bool = false // Disable button logic
//    
//    let points = [10, 25, 50] // Possible bonus points
//    
//    var body: some View {
//        VStack(spacing: 20) {
//          //  TimerView()
//        }
//        .padding()
//        .onAppear {
//            checkButtonState()
//        }
//    }
//    
//    // Handle button press logic
//    private func handleButtonPress() {
//        bonusPoints = points.randomElement() // Randomly select bonus
//        lastPressDate = Date() // Update last press date
//        UserDefaults.standard.set(lastPressDate, forKey: "LastPressDate") // Save to UserDefaults
//        isButtonDisabled = true // Disable button
//        
//        // Optionally refresh button state after 24 hours
//        DispatchQueue.main.asyncAfter(deadline: .now() + 24 * 60 * 60) {
//            checkButtonState()
//        }
//    }
//    
//    // Check if button can be pressed
//    private func checkButtonState() {
//        if let savedDate = UserDefaults.standard.object(forKey: "LastPressDate") as? Date {
//            let elapsedTime = Date().timeIntervalSince(savedDate)
//            if elapsedTime >= 24 * 60 * 60 {
//                isButtonDisabled = false // Re-enable button
//            } else {
//                isButtonDisabled = true
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}
