//
//  HomeScreen.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//
import SwiftUI

struct HomeScreen: View {
    // MARK: - State & Environment
    @StateObject private var viewModel = RecipeViewModel()
    @EnvironmentObject var languageManager: LanguageManager
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: Header Title
                Text(languageManager.language == "en" ? "Recipes" : "الوصفات")
                    .font(.largeTitle)
                    .foregroundColor(.brown)
                    .bold()
                    .padding(.top)
                    .padding(.horizontal)
                
                // MARK: Search Field
                TextField(
                    languageManager.language == "en" ? "Search recipes..." : "ابحث عن وصفة",
                    text: $viewModel.searchText
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                
                // MARK: Loading & Error States
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    // MARK: Recipes List
                    List(viewModel.filteredRecipes) { recipe in
                        HStack(spacing: 12) {
                            
                            // MARK: Recipe Image
                            if recipe.image.starts(with: "http") {
                                AsyncImage(url: URL(string: recipe.image)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                                .clipped()
                            } else {
                                Image(recipe.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                    .clipped()
                            }
                            
                            // MARK: Recipe Info
                            VStack(alignment: .leading, spacing: 4) {
                                Text(recipe.name)
                                    .font(.headline)
                                    .bold()
                                
                                Text(recipe.instructions)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                            
                            // MARK: Favorite Button
                            Button {
                                viewModel.toggleFavorite(recipe)
                            } label: {
                                Image(systemName: viewModel.isFavorite(recipe) ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                            }
                            
                            // MARK: Navigation to Detail
                            NavigationLink("", destination: RecipeDetailView(recipe: recipe)
                                .environmentObject(languageManager)
                                .environmentObject(viewModel))
                            .frame(width: 0)
                            .opacity(0)
                        }
                        .padding(.vertical, 6)
                    }
                    .listStyle(.plain)
                }
            }
            // MARK: Toolbar
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // MARK: Language Toggle
                    Button {
                        languageManager.toggleLanguage()
                    } label: {
                        Text(languageManager.language == "en" ? "AR 🇸🇦" : "EN 🇺🇸")
                            .font(.caption)
                            .padding(6)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(8)
                    }
                    
                    // MARK: Favorites Navigation
                    NavigationLink(destination: FavoritesView()
                        .environmentObject(viewModel)
                        .environmentObject(languageManager)) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                }
            }
            .onAppear {
                viewModel.fetchRecipes()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SplashScreenView()
        .environmentObject(LanguageManager())
}
