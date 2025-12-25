//
//  FavoritesView.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//

import SwiftUI

struct FavoritesView: View {
    // MARK: - Environment Objects
    @EnvironmentObject var viewModel: RecipeViewModel
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) var dismiss

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: Empty State
                if viewModel.favorites.isEmpty {
                    Text(languageManager.language == "en"
                         ? "No favorite recipes."
                         : "لا توجد وصفات مفضلة.")
                        .foregroundColor(.brown)
                        .padding()
                }
                // MARK: Favorites List
                else {
                    List {
                        ForEach(viewModel.favorites) { recipe in
                            NavigationLink(destination:
                                RecipeDetailView(recipe: recipe)
                                    .environmentObject(languageManager)
                                    .environmentObject(viewModel)
                            ) {
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
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding(.vertical, 6)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            // MARK: Navigation Bar
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text(languageManager.language == "en" ? "Recipes" : "الوصفات")
                        }
                        .foregroundColor(.brown)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

