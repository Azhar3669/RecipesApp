//
//  Recipe.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//
import Foundation

struct RecipeResponse: Decodable {
    let meals: [Recipe]
}

struct Recipe: Identifiable, Decodable {
    var id: String { idMeal }
    
    let idMeal: String
    let name: String
    let instructions: String
    let image: String
    let ingredients: [String]
    
    init(idMeal: String,
         name: String,
         instructions: String,
         image: String,
         ingredients: [String]) {
        self.idMeal = idMeal
        self.name = name
        self.instructions = instructions
        self.image = image
        self.ingredients = ingredients
    }
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case name = "strMeal"
        case instructions = "strInstructions"
        case image = "strMealThumb"
        
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        image = try container.decode(String.self, forKey: .image)
        
        var tempIngredients: [String] = []
        
        for i in 1...20 {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(i)")!
            
            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.trimmingCharacters(in: .whitespaces).isEmpty {
                
                let measure = try container.decodeIfPresent(String.self, forKey: measureKey) ?? ""
                let ingredientString = measure.isEmpty ? ingredient : "\(ingredient) - \(measure)"
                tempIngredients.append(ingredientString)
            }
        }
        
        ingredients = tempIngredients
    }
}
