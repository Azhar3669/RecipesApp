//
//  LanguageManager.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//

import Foundation
import SwiftUI

final class LanguageManager: ObservableObject {
    

    @Published var language: String {
        didSet {
            saveLanguage()
        }
    }
    

    private let languageKey = "AppLanguage"
    
    init() {

        if let savedLanguage = UserDefaults.standard.string(forKey: languageKey) {
            self.language = savedLanguage
        } else {

            self.language = Locale.current.language.languageCode?.identifier ?? "en"
        }
        
        applyLanguage()
    }
    

    func toggleLanguage() {
        language = (language == "ar") ? "en" : "ar"
        applyLanguage()
    }
    

    private func applyLanguage() {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    

    private func saveLanguage() {
        UserDefaults.standard.set(language, forKey: languageKey)
    }
    

    var layoutDirection: LayoutDirection {
        language == "ar" ? .rightToLeft : .leftToRight
    }
}
