//
//  LanguageManager.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//

import Foundation
import SwiftUI

final class LanguageManager: ObservableObject {
    @Published var language: String = "en"

    func toggleLanguage() {
        language = (language == "ar") ? "en" : "ar"
    }

    var layoutDirection: LayoutDirection {
        language == "ar" ? .rightToLeft : .leftToRight
    }
}
