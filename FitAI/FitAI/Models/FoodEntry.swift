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
    
    init(
        id: String,
        userId: String,
        date: Date,
        mealType: MealType,
        foodName: String,
        calories: Double,
        protein: Double,
        carbs: Double,
        fat: Double,
        servingSize: String? = nil,
        photoURL: String? = nil,
        aiAnalyzed: Bool = false,
        aiConfidence: Double? = nil,
        notes: String? = nil,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = id
        self.userId = userId
        self.date = date
        self.mealType = mealType
        self.foodName = foodName
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.servingSize = servingSize
        self.photoURL = photoURL
        self.aiAnalyzed = aiAnalyzed
        self.aiConfidence = aiConfidence
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
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
    
    private static let supabaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private static let isoFormatterWithFractional: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private static func parseDate(_ value: String) -> Date? {
        if let date = supabaseDateFormatter.date(from: value) {
            return date
        }
        if let date = isoFormatterWithFractional.date(from: value) {
            return date
        }
        if let date = isoFormatter.date(from: value) {
            return date
        }
        return nil
    }
    
    private static func decodeDouble(
        from container: KeyedDecodingContainer<CodingKeys>,
        forKey key: CodingKeys
    ) throws -> Double {
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let stringValue = try? container.decode(String.self, forKey: key),
           let doubleValue = Double(stringValue) {
            return doubleValue
        }
        throw DecodingError.dataCorruptedError(
            forKey: key,
            in: container,
            debugDescription: "Expected Double or numeric String for \(key.rawValue)"
        )
    }
    
    private static func decodeOptionalDouble(
        from container: KeyedDecodingContainer<CodingKeys>,
        forKey key: CodingKeys
    ) throws -> Double? {
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let stringValue = try? container.decode(String.self, forKey: key),
           let doubleValue = Double(stringValue) {
            return doubleValue
        }
        return nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        userId = try container.decode(String.self, forKey: .userId)
        
        let dateString = try container.decode(String.self, forKey: .date)
        guard let parsedDate = FoodEntry.parseDate(dateString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .date,
                in: container,
                debugDescription: "Invalid date format: \(dateString)"
            )
        }
        date = parsedDate
        
        let mealTypeValue = try container.decode(String.self, forKey: .mealType)
        guard let parsedMealType = MealType(rawValue: mealTypeValue) else {
            throw DecodingError.dataCorruptedError(
                forKey: .mealType,
                in: container,
                debugDescription: "Invalid meal type: \(mealTypeValue)"
            )
        }
        mealType = parsedMealType
        
        foodName = try container.decode(String.self, forKey: .foodName)
        calories = try FoodEntry.decodeDouble(from: container, forKey: .calories)
        protein = try FoodEntry.decodeDouble(from: container, forKey: .protein)
        carbs = try FoodEntry.decodeDouble(from: container, forKey: .carbs)
        fat = try FoodEntry.decodeDouble(from: container, forKey: .fat)
        servingSize = try container.decodeIfPresent(String.self, forKey: .servingSize)
        photoURL = try container.decodeIfPresent(String.self, forKey: .photoURL)
        aiAnalyzed = (try? container.decode(Bool.self, forKey: .aiAnalyzed)) ?? false
        aiConfidence = try FoodEntry.decodeOptionalDouble(from: container, forKey: .aiConfidence)
        notes = try container.decodeIfPresent(String.self, forKey: .notes)
        
        if let createdString = try? container.decode(String.self, forKey: .createdAt),
           let parsedCreated = FoodEntry.parseDate(createdString) {
            createdAt = parsedCreated
        } else if let createdDate = try? container.decode(Date.self, forKey: .createdAt) {
            createdAt = createdDate
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .createdAt,
                in: container,
                debugDescription: "Invalid created_at format"
            )
        }
        
        if let updatedString = try? container.decode(String.self, forKey: .updatedAt),
           let parsedUpdated = FoodEntry.parseDate(updatedString) {
            updatedAt = parsedUpdated
        } else if let updatedDate = try? container.decode(Date.self, forKey: .updatedAt) {
            updatedAt = updatedDate
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .updatedAt,
                in: container,
                debugDescription: "Invalid updated_at format"
            )
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        let dateString = FoodEntry.supabaseDateFormatter.string(from: date)
        try container.encode(dateString, forKey: .date)
        try container.encode(mealType.rawValue, forKey: .mealType)
        try container.encode(foodName, forKey: .foodName)
        try container.encode(calories, forKey: .calories)
        try container.encode(protein, forKey: .protein)
        try container.encode(carbs, forKey: .carbs)
        try container.encode(fat, forKey: .fat)
        try container.encodeIfPresent(servingSize, forKey: .servingSize)
        try container.encodeIfPresent(photoURL, forKey: .photoURL)
        try container.encode(aiAnalyzed, forKey: .aiAnalyzed)
        try container.encodeIfPresent(aiConfidence, forKey: .aiConfidence)
        try container.encodeIfPresent(notes, forKey: .notes)
        let createdString = FoodEntry.isoFormatterWithFractional.string(from: createdAt)
        try container.encode(createdString, forKey: .createdAt)
        let updatedString = FoodEntry.isoFormatterWithFractional.string(from: updatedAt)
        try container.encode(updatedString, forKey: .updatedAt)
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

