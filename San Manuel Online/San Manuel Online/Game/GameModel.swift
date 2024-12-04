//
//  GameModel.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 04.12.2024.
//

import Foundation

struct Amulet: Hashable, Equatable, Codable {
    var id = UUID()
    var imageName: String
    var color: String
}
