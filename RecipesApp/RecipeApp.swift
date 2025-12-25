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
    
    init() {
        UserDefaults.standard.set([languageManager.language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(languageManager)
                .environment(
                    \.layoutDirection,
                     languageManager.language == "ar"
                     ? .rightToLeft
                     : .leftToRight
                )
            
            SplashScreenView()
            
        }
    }
}
