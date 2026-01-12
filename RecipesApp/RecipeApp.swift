//
//  RecipeApp.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//

import SwiftUI

@main
struct RecipesApp: App {
    @StateObject private var languageManager = LanguageManager()

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(languageManager)
//                .environment(\.layoutDirection, languageManager.layoutDirection)
        }
    }
}
