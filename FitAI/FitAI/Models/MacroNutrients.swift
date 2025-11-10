//
//  MacroNutrients.swift
//  FitAI
//
//  Macronutrients model
//

import Foundation

struct MacroNutrients: Codable {
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
    
    static let zero = MacroNutrients(calories: 0, protein: 0, carbs: 0, fat: 0)
    
    static func + (lhs: MacroNutrients, rhs: MacroNutrients) -> MacroNutrients {
        return MacroNutrients(
            calories: lhs.calories + rhs.calories,
            protein: lhs.protein + rhs.protein,
            carbs: lhs.carbs + rhs.carbs,
            fat: lhs.fat + rhs.fat
        )
    }
}

