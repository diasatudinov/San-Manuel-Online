//
//  Links.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 06.12.2024.
//

import SwiftUI

class Links {
    
    static let shared = Links()
    
    static let winStarData = "https://sanmanuelonline.xyz/data"
    // "https://spiritgaming.xyz/icon?page=test"
    // "https://sanmanuelonline.xyz/data"
    static let ruleURL = "https://sanmanuelonline.xyz/rule.html"
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
