//
//  wordPuzzleApp.swift
//  wordPuzzleApp
//
//  Created by Wesley Gore on 3/27/24.
//

import SwiftUI

@main
struct wordPuzzleApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
        .modelContainer(for: [StandardSaveModel.self, RushSaveModel.self, FrenzySaveModel.self, ZenSaveModel.self, DailySaveModel.self])
    }
}
