//
//  DM_CompanionApp.swift
//  DM_Companion
//
//  Created by Ishaan Bedi on 10/06/23.
//

import SwiftUI
import SwiftData

@main
struct DM_CompanionApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
