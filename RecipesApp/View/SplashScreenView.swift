//
//  SplashScreenView.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//
import SwiftUI

struct SplashScreenView: View {
    // MARK: - State & Environment
    @StateObject private var viewModel = SplashViewModel()
    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0.0
    @EnvironmentObject var languageManager: LanguageManager
    
    // MARK: - Body
    var body: some View {
        if viewModel.isActive {
            HomeScreen()
        } else {
            // MARK: Splash Screen
            VStack(spacing: 20) {
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 2.0)) {
                            scale = 1.2
                            opacity = 1.0
                        }
                    }
                
                Text(languageManager.language == "en" ? "Recipe App" : "تطبيق الوصفات")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .bold()
                    .opacity(opacity)
                    .animation(.easeIn(duration: 2.0), value: opacity)
                
                Text(languageManager.language == "en"
                     ? "Delicious recipes for everyone"
                     : "وصفات لذيذة للجميع")
                .foregroundColor(.brown)
                .opacity(opacity)
                .animation(.easeIn(duration: 1.5), value: opacity)
                
                Button {
                    languageManager.toggleLanguage()
                } label: {
                    Text(languageManager.language == "ar" ? "AR 🇸🇦" : "EN 🇺🇸")
                        .font(.caption)
                        .padding(6)
                        .background(Color.orange.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
            // MARK: Start Splash Timer
            .onAppear {
                viewModel.start()
            }
        }
    }
}
