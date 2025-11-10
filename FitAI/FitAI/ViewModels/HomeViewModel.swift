//
//  HomeViewModel.swift
//  FitAI
//
//  Home view model
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var foodEntries: [FoodEntry] = []
    @Published var dailyGoal: DailyGoal?
    @Published var dailyTotals: MacroNutrients = .zero
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let databaseService = DatabaseService.shared
    private let goalTrackingService = GoalTrackingService.shared
    private let authService = AuthService.shared
    
    func loadTodayData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Load today's food entries
            let today = Date()
            foodEntries = try await databaseService.getFoodEntries(for: today)
            
            // Calculate daily totals
            dailyTotals = goalTrackingService.calculateDailyTotals(foodEntries)
            
            // Load active goal
            dailyGoal = try await databaseService.getActiveGoal()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    var remainingCalories: Double {
        guard let goal = dailyGoal else { return 0 }
        return goalTrackingService.calculateRemainingCalories(
            dailyTotals: dailyTotals,
            goal: goal
        )
    }
    
    var isGoalAchieved: Bool {
        guard let goal = dailyGoal else { return false }
        return goalTrackingService.isGoalAchieved(
            dailyTotals: dailyTotals,
            goal: goal
        )
    }
    
    var calorieProgress: Double {
        guard let goal = dailyGoal, goal.dailyCalorieGoal > 0 else { return 0 }
        return min(dailyTotals.calories / Double(goal.dailyCalorieGoal), 1.0)
    }
}

