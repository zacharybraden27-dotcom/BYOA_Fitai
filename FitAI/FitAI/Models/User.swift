//
//  User.swift
//  FitAI
//
//  User model
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    var name: String?
    var currentWeight: Double?
    var targetWeight: Double?
    var height: Double?
    var dateOfBirth: Date?
    var activityLevel: String?
    let createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case currentWeight = "current_weight"
        case targetWeight = "target_weight"
        case height
        case dateOfBirth = "date_of_birth"
        case activityLevel = "activity_level"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

