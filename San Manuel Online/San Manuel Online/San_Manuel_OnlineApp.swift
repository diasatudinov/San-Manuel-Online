//
//  San_Manuel_OnlineApp.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 02.12.2024.
//

import SwiftUI

@main
struct San_Manuel_OnlineApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.light)
        }
    }
}
