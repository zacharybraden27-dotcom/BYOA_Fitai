//
//  FoodAnalysisResult.swift
//  FitAI
//
//  Food analysis result from AI service
//

import Foundation

struct FoodAnalysisResult: Codable {
    let foodName: String
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
    let servingSize: String?
    let confidence: Double
    var multipleItems: [FoodItem]?
    
    struct FoodItem: Codable {
        let name: String
        let calories: Double
        let protein: Double
        let carbs: Double
        let fat: Double
        let servingSize: String?
    }
}

