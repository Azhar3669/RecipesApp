//
//  RecipeViewModel.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//

import Foundation

class RecipeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var recipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var favorites: [Recipe] = []
    @Published var searchText: String = "" {
        didSet { filterRecipes() }
    }
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Local Recipes
    private func loadLocalRecipes() -> [Recipe] {
        return [
            Recipe(
                idMeal: "local1",
                name: "Pancakes",
                instructions: "Delicious breakfast pancakes.",
                image: "pancakes",
                ingredients: ["Flour", "Milk", "Eggs"]
            ),
            Recipe(
                idMeal: "local2",
                name: "Caesar Salad",
                instructions: "Famous Caesar salad.",
                image: "salad",
                ingredients: ["Lettuce", "Chicken pieces", "Caesar dressing"]
            ),
            Recipe(
                idMeal: "local3",
                name: "Chocolate Cake",
                instructions: "Delicious chocolate cake.",
                image: "cake",
                ingredients: ["Flour", "Sugar", "Cocoa powder"]
            ),
            Recipe(
                idMeal: "local4",
                name: "Grilled Chicken",
                instructions: "Tasty grilled chicken.",
                image: "chicken",
                ingredients: ["Chicken", "Spices", "Oil"]
            )
        ]
    }
    
    // MARK: - Fetch Recipes (via API Service)
    func fetchRecipes() {
        isLoading = true
        errorMessage = nil
        
        var combinedRecipes = loadLocalRecipes()
        
        RecipeAPIService.shared.fetchRecipes { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let apiRecipes):
                    combinedRecipes.append(contentsOf: apiRecipes)
                    self?.recipes = combinedRecipes
                    self?.filterRecipes()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.recipes = combinedRecipes
                    self?.filteredRecipes = combinedRecipes
                }
            }
        }
    }
    
    // MARK: - Filter Recipes by Search Text
    func filterRecipes() {
        if searchText.isEmpty {
            filteredRecipes = recipes
        } else {
            filteredRecipes = recipes.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    // MARK: - Favorite Management
    func toggleFavorite(_ recipe: Recipe) {
        if let index = favorites.firstIndex(where: { $0.id == recipe.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(recipe)
        }
    }
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        favorites.contains(where: { $0.id == recipe.id })
    }
}
