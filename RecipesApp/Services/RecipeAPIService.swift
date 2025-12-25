//
//  RecipeAPIService.swift
//  RecipesApp
//
//  Created by Azhar Ghurab on 25/06/1447 AH.
//

import Foundation

class RecipeAPIService {
    
    static let shared = RecipeAPIService()
    private init() {}
    
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=") else {
            completion(.success([]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.success([]))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
                completion(.success(decoded.meals))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
