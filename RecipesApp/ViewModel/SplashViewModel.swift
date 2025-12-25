//
//  SplashViewModel.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var isActive = false
    
    func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.isActive = true
        }
    }
}
