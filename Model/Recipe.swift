
import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let ingredients: [String]
    let steps: [String]
}
