//
//  DatabaseService.swift
//  FitAI
//
//  Database service for data operations
//

import Foundation

class DatabaseService {
    static let shared = DatabaseService()
    
    private let networkService = NetworkService.shared
    private let authService = AuthService.shared
    private let mockDataService = MockDataService.shared
    
    private init() {}
    
    // MARK: - User Operations
    
    func updateUser(_ user: User) async throws -> User {
        if AppConfig.useMockData {
            return mockDataService.updateUser(user)
        }
        
        let headers = authService.getAuthHeaders()
        // TODO: Replace with actual API endpoint
        return try await networkService.put(
            endpoint: "/users/\(user.id)",
            body: user,
            headers: headers
        )
    }
    
    // MARK: - Food Entry Operations
    
    func createFoodEntry(_ foodEntry: FoodEntry) async throws -> FoodEntry {
        if AppConfig.useMockData {
            return mockDataService.createFoodEntry(foodEntry)
        }
        
        let headers = authService.getAuthHeaders()
        // TODO: Replace with actual API endpoint
        return try await networkService.post(
            endpoint: "/food-entries",
            body: foodEntry,
            headers: headers
        )
    }
    
    func getFoodEntries(for date: Date) async throws -> [FoodEntry] {
        if AppConfig.useMockData {
            guard let currentUser = authService.getCurrentUser() else {
                return []
            }
            return mockDataService.getFoodEntries(userId: currentUser.id, for: date)
        }
        
        let headers = authService.getAuthHeaders()
        let dateFormatter = ISO8601DateFormatter()
        let dateString = dateFormatter.string(from: date)
        // TODO: Replace with actual API endpoint
        return try await networkService.get(
            endpoint: "/food-entries?date=\(dateString)",
            headers: headers
        )
    }
    
    func updateFoodEntry(_ foodEntry: FoodEntry) async throws -> FoodEntry {
        if AppConfig.useMockData {
            return mockDataService.updateFoodEntry(foodEntry)
        }
        
        let headers = authService.getAuthHeaders()
        // TODO: Replace with actual API endpoint
        return try await networkService.put(
            endpoint: "/food-entries/\(foodEntry.id)",
            body: foodEntry,
            headers: headers
        )
    }
    
    func deleteFoodEntry(_ foodEntry: FoodEntry) async throws {
        if AppConfig.useMockData {
            mockDataService.deleteFoodEntry(foodEntry)
            return
        }
        
        let headers = authService.getAuthHeaders()
        // TODO: Replace with actual API endpoint
        let _: EmptyResponse = try await networkService.delete(
            endpoint: "/food-entries/\(foodEntry.id)",
            headers: headers
        )
    }
    
    // MARK: - Goal Operations
    
    func createGoal(_ goal: DailyGoal) async throws -> DailyGoal {
        if AppConfig.useMockData {
            return mockDataService.createGoal(goal)
        }
        
        let headers = authService.getAuthHeaders()
        // TODO: Replace with actual API endpoint
        return try await networkService.post(
            endpoint: "/goals",
            body: goal,
            headers: headers
        )
    }
    
    func getActiveGoal() async throws -> DailyGoal? {
        if AppConfig.useMockData {
            guard let currentUser = authService.getCurrentUser() else {
                return nil
            }
            return mockDataService.getActiveGoal(userId: currentUser.id)
        }
        
        let headers = authService.getAuthHeaders()
        // TODO: Replace with actual API endpoint
        return try await networkService.get(
            endpoint: "/goals/active",
            headers: headers
        )
    }
    
    func updateGoal(_ goal: DailyGoal) async throws -> DailyGoal {
        if AppConfig.useMockData {
            return mockDataService.updateGoal(goal)
        }
        
        let headers = authService.getAuthHeaders()
        // TODO: Replace with actual API endpoint
        return try await networkService.put(
            endpoint: "/goals/\(goal.id)",
            body: goal,
            headers: headers
        )
    }
}

struct EmptyResponse: Codable {}
