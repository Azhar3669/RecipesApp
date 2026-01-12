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

    private var isArabic: Bool {
        languageManager.language == "ar"
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {

                // MARK: Title
                Text(isArabic ? "الوصفات" : "Recipes")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.brown)
                    .padding(.top)

                // MARK: Search
                TextField(
                    isArabic ? "ابحث عن وصفة" : "Search recipes...",
                    text: $viewModel.searchText
                )
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

                // MARK: Content
                if viewModel.isLoading {
                    ProgressView().padding()

                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()

                } else {
                    List(viewModel.filteredRecipes) { recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: recipe)
                                .environmentObject(viewModel)
                                .environmentObject(languageManager)
                        } label: {
                            RecipeRow(
                                recipe: recipe,
                                isArabic: isArabic,
                                isFavorite: viewModel.isFavorite(recipe),
                                favoriteAction: {
                                    viewModel.toggleFavorite(recipe)
                                }
                            )
                        }
                    }
                    .listStyle(.plain)
                    
                }
            }
            // MARK: Toolbar
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {

                    Button {
                        languageManager.toggleLanguage()
                    } label: {
                        Text(isArabic ? "AR 🇸🇦" : "EN 🇺🇸")
                            .font(.caption)
                            .padding(6)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }

                    NavigationLink {
                        FavoritesView()
                            .environmentObject(viewModel)
                            .environmentObject(languageManager)
                    } label: {
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


// MARK: - Recipe Row

struct RecipeRow: View {

    let recipe: Recipe
    let isArabic: Bool
    let isFavorite: Bool
    let favoriteAction: () -> Void

    var body: some View {
        HStack(spacing: 12) {

            if isArabic {
                RecipeImage(url: recipe.image)

                RecipeInfo(recipe: recipe, alignment: .trailing)

                Spacer()

                FavoriteButton
            } else {
                FavoriteButton

                RecipeInfo(recipe: recipe, alignment: .leading)

                Spacer()

                RecipeImage(url: recipe.image)
            }
        }
        .padding(.vertical, 6)
    }

    private var FavoriteButton: some View {
        Button(action: favoriteAction) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.red)
        }
        .buttonStyle(.plain)
        
    }
}


// MARK: - Recipe Info

struct RecipeInfo: View {

    let recipe: Recipe
    let alignment: HorizontalAlignment

    var body: some View {
        VStack(alignment: alignment, spacing: 4) {
            Text(recipe.name)
                .font(.headline)
                .bold()

            Text(recipe.instructions)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
                .multilineTextAlignment(
                    alignment == .leading ? .leading : .trailing
                )
        }
    }
}


// MARK: - Recipe Image

struct RecipeImage: View {

    let url: String

    var body: some View {
        if url.starts(with: "http") {
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 80, height: 80)
            .cornerRadius(10)
        } else {
            Image(url)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .clipped()
        }
    }
    
}


// MARK: - Preview

#Preview {
   HomeScreen()
        .environmentObject(LanguageManager())
}
