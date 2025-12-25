//
//  RecipeDetailView.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//
import SwiftUI

struct RecipeDetailView: View {
    // MARK: - Properties
    let recipe: Recipe
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var languageManager: LanguageManager
    @EnvironmentObject var viewModel: RecipeViewModel
    
    // MARK: - Computed Properties
    var steps: [String] {
        recipe.instructions
            .components(separatedBy: ".")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // MARK: Recipe Image
                if recipe.image.starts(with: "http") {
                    AsyncImage(url: URL(string: recipe.image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 260)
                    .cornerRadius(16)
                    .clipped()
                } else {
                    Image(recipe.image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 260)
                        .cornerRadius(16)
                        .clipped()
                }
                
                // MARK: Recipe Title & Favorite Button
                HStack {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleFavorite(recipe)
                    }) {
                        Image(systemName: viewModel.isFavorite(recipe) ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isFavorite(recipe) ? .red : .gray)
                            .font(.title)
                    }
                }
                .padding(.top)
                
                // MARK: Instructions
                Text(recipe.instructions)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.vertical, 4)
                
                Text(languageManager.language == "en" ? "Ingredients" : "المكونات")
                    .font(.title2)
                    .bold()
                    .padding(.top, 8)
                
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text(ingredient)
                    }
                }
                
                Divider()
                
                Text(languageManager.language == "en" ? "Steps" : "الخطوات")
                    .font(.title2)
                    .bold()
                
                ForEach(steps, id: \.self) { step in
                    Text("• \(step)")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        // MARK: Navigation Bar
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
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
    }
}
