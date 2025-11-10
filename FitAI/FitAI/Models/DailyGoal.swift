//
//  DailyGoal.swift
//  FitAI
//
//  Daily goal model
//

import Foundation

struct DailyGoal: Codable, Identifiable {
    let id: String
    let userId: String
    let dailyCalorieGoal: Int
    let dailyProteinGoal: Int
    let dailyCarbGoal: Int
    let dailyFatGoal: Int
    var calorieDeficitGoal: Int?
    var calorieSurplusGoal: Int?
    var isActive: Bool
    let createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case dailyCalorieGoal = "daily_calorie_goal"
        case dailyProteinGoal = "daily_protein_goal"
        case dailyCarbGoal = "daily_carb_goal"
        case dailyFatGoal = "daily_fat_goal"
        case calorieDeficitGoal = "calorie_deficit_goal"
        case calorieSurplusGoal = "calorie_surplus_goal"
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

