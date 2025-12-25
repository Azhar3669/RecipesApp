
import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []

    init() {
        loadRecipes()
    }

    func loadRecipes() {
        recipes = [
            Recipe(name: "Spaghetti Bolognese", image: "spaghetti",
                   description: "Classic spaghetti with meat sauce.",
                   ingredients: ["Spaghetti", "Beef", "Tomato Sauce"],
                   steps: ["Boil pasta", "Cook sauce", "Mix together"]),
            Recipe(name: "Pancakes", image: "pancakes",
                   description: "Fluffy breakfast pancakes.",
                   ingredients: ["Flour", "Milk", "Eggs"],
                   steps: ["Mix ingredients", "Cook on pan"]),
            Recipe(name: "Grilled Chicken", image: "chicken",
                   description: "Juicy grilled chicken.",
                   ingredients: ["Chicken", "Spices"],
                   steps: ["Season chicken", "Grill well"])
        ]
    }
}
