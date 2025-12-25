//
//  LanguageManager.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//

import SwiftUI

class LanguageManager: ObservableObject {
    @AppStorage("appLanguage") var language: String = "en"

    func toggleLanguage() {
        language = (language == "en") ? "ar" : "en"
    }
}
