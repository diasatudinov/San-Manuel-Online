//
//  UserManager.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 03.12.2024.
//

import SwiftUI

class User: ObservableObject {
    static let shared = User()
    
    @AppStorage("coins") var storedCoins: Int = 100
    @Published var coins: Int = 10
    
    init() {
        coins = storedCoins
    }
    
    func updateUserCoins(for coins: Int) {
        self.coins += coins
        storedCoins = self.coins
    }
    
    func minusUserCoins(for coins: Int) {
        self.coins -= coins
        storedCoins = self.coins
    }
}
