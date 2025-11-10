//
//  GoalTrackingService.swift
//  FitAI
//
//  Goal tracking service
//

import Foundation

class GoalTrackingService {
    static let shared = GoalTrackingService()
    
    private let databaseService = DatabaseService.shared
    
    private init() {}
    
    // Calculate daily totals from food entries
    func calculateDailyTotals(_ foodEntries: [FoodEntry]) -> MacroNutrients {
        return foodEntries.reduce(MacroNutrients.zero) { total, entry in
            MacroNutrients(
                calories: total.calories + entry.calories,
                protein: total.protein + entry.protein,
                carbs: total.carbs + entry.carbs,
                fat: total.fat + entry.fat
            )
        }
    }
    
    // Check if goal is achieved
    func isGoalAchieved(dailyTotals: MacroNutrients, goal: DailyGoal) -> Bool {
        return dailyTotals.calories >= Double(goal.dailyCalorieGoal)
    }
    
    // Calculate remaining calories
    func calculateRemainingCalories(dailyTotals: MacroNutrients, goal: DailyGoal) -> Double {
        return Double(goal.dailyCalorieGoal) - dailyTotals.calories
    }
}

