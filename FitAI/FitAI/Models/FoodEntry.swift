//
//  FoodEntry.swift
//  FitAI
//
//  Food entry model
//

import Foundation

struct FoodEntry: Codable, Identifiable {
    let id: String
    let userId: String
    let date: Date
    let mealType: MealType
    let foodName: String
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
    var servingSize: String?
    var photoURL: String?
    let aiAnalyzed: Bool
    var aiConfidence: Double?
    var notes: String?
    let createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case date
        case mealType = "meal_type"
        case foodName = "food_name"
        case calories
        case protein
        case carbs
        case fat
        case servingSize = "serving_size"
        case photoURL = "photo_url"
        case aiAnalyzed = "ai_analyzed"
        case aiConfidence = "ai_confidence"
        case notes
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum MealType: String, Codable, CaseIterable {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case dinner = "dinner"
    case snack = "snack"
    
    var displayName: String {
        return rawValue.capitalized
    }
}

