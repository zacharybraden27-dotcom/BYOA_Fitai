//
//  MockDataService.swift
//  FitAI
//
//  Mock data service for testing and demo purposes
//

import Foundation

class MockDataService {
    static let shared = MockDataService()
    
    // Mock user credentials
    static let mockEmail = "demo@fitai.com"
    static let mockPassword = "demo123"
    
    // In-memory storage
    private var users: [String: User] = [:]
    private var foodEntries: [String: [FoodEntry]] = [:]
    private var goals: [String: DailyGoal] = [:]
    
    private init() {
        initializeMockData()
    }
    
    // MARK: - Initialization
    
    private func initializeMockData() {
        // Create mock user
        let mockUser = User(
            id: "user_001",
            email: MockDataService.mockEmail,
            name: "Demo User",
            currentWeight: 75.0,
            targetWeight: 70.0,
            height: 175.0,
            dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date()),
            activityLevel: "moderate",
            createdAt: Date(),
            updatedAt: Date()
        )
        users[mockUser.id] = mockUser
        
        // Create mock daily goal
        let mockGoal = DailyGoal(
            id: "goal_001",
            userId: mockUser.id,
            dailyCalorieGoal: 2000,
            dailyProteinGoal: 150,
            dailyCarbGoal: 200,
            dailyFatGoal: 65,
            calorieDeficitGoal: 500,
            calorieSurplusGoal: nil,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        )
        goals[mockUser.id] = mockGoal
        
        // Create mock food entries for today
        let today = Calendar.current.startOfDay(for: Date())
        var entries: [FoodEntry] = []
        
        // Breakfast entries
        entries.append(createFoodEntry(
            id: "entry_001",
            userId: mockUser.id,
            date: today,
            mealType: .breakfast,
            foodName: "Scrambled Eggs with Toast",
            calories: 350,
            protein: 20,
            carbs: 30,
            fat: 15
        ))
        
        entries.append(createFoodEntry(
            id: "entry_002",
            userId: mockUser.id,
            date: today,
            mealType: .breakfast,
            foodName: "Greek Yogurt with Berries",
            calories: 180,
            protein: 15,
            carbs: 25,
            fat: 5
        ))
        
        // Lunch entries
        entries.append(createFoodEntry(
            id: "entry_003",
            userId: mockUser.id,
            date: today,
            mealType: .lunch,
            foodName: "Grilled Chicken Salad",
            calories: 450,
            protein: 40,
            carbs: 20,
            fat: 20
        ))
        
        entries.append(createFoodEntry(
            id: "entry_004",
            userId: mockUser.id,
            date: today,
            mealType: .lunch,
            foodName: "Quinoa Bowl",
            calories: 320,
            protein: 12,
            carbs: 55,
            fat: 8
        ))
        
        // Snack entries
        entries.append(createFoodEntry(
            id: "entry_005",
            userId: mockUser.id,
            date: today,
            mealType: .snack,
            foodName: "Apple with Almond Butter",
            calories: 200,
            protein: 5,
            carbs: 25,
            fat: 10
        ))
        
        // Dinner entries
        entries.append(createFoodEntry(
            id: "entry_006",
            userId: mockUser.id,
            date: today,
            mealType: .dinner,
            foodName: "Salmon with Sweet Potato",
            calories: 550,
            protein: 45,
            carbs: 60,
            fat: 18
        ))
        
        entries.append(createFoodEntry(
            id: "entry_007",
            userId: mockUser.id,
            date: today,
            mealType: .dinner,
            foodName: "Steamed Broccoli",
            calories: 50,
            protein: 3,
            carbs: 8,
            fat: 0
        ))
        
        // Add some entries from previous days
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        entries.append(createFoodEntry(
            id: "entry_008",
            userId: mockUser.id,
            date: yesterday,
            mealType: .breakfast,
            foodName: "Oatmeal with Banana",
            calories: 300,
            protein: 10,
            carbs: 55,
            fat: 6
        ))
        
        entries.append(createFoodEntry(
            id: "entry_009",
            userId: mockUser.id,
            date: yesterday,
            mealType: .lunch,
            foodName: "Turkey Sandwich",
            calories: 420,
            protein: 30,
            carbs: 45,
            fat: 12
        ))
        
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: today)!
        entries.append(createFoodEntry(
            id: "entry_010",
            userId: mockUser.id,
            date: twoDaysAgo,
            mealType: .breakfast,
            foodName: "Smoothie Bowl",
            calories: 280,
            protein: 8,
            carbs: 50,
            fat: 5
        ))
        
        foodEntries[mockUser.id] = entries
    }
    
    private func createFoodEntry(
        id: String,
        userId: String,
        date: Date,
        mealType: MealType,
        foodName: String,
        calories: Double,
        protein: Double,
        carbs: Double,
        fat: Double
    ) -> FoodEntry {
        return FoodEntry(
            id: id,
            userId: userId,
            date: date,
            mealType: mealType,
            foodName: foodName,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fat: fat,
            servingSize: "1 serving",
            photoURL: nil,
            aiAnalyzed: true,
            aiConfidence: 0.92,
            notes: "AI analyzed",
            createdAt: date,
            updatedAt: date
        )
    }
    
    // MARK: - User Operations
    
    func getUser(byId userId: String) -> User? {
        return users[userId]
    }
    
    func getUser(byEmail email: String) -> User? {
        return users.values.first { $0.email == email }
    }
    
    func updateUser(_ user: User) -> User {
        // Since User has var properties for most fields, we can update them directly
        // But we need to create a new instance with updated updatedAt
        let updatedUser = User(
            id: user.id,
            email: user.email,
            name: user.name,
            currentWeight: user.currentWeight,
            targetWeight: user.targetWeight,
            height: user.height,
            dateOfBirth: user.dateOfBirth,
            activityLevel: user.activityLevel,
            createdAt: user.createdAt,
            updatedAt: Date()
        )
        users[user.id] = updatedUser
        return updatedUser
    }
    
    // MARK: - Food Entry Operations
    
    func getFoodEntries(userId: String, for date: Date) -> [FoodEntry] {
        guard let allEntries = foodEntries[userId] else { return [] }
        let calendar = Calendar.current
        let targetDay = calendar.startOfDay(for: date)
        return allEntries.filter { entry in
            calendar.startOfDay(for: entry.date) == targetDay
        }
    }
    
    func createFoodEntry(_ entry: FoodEntry) -> FoodEntry {
        if foodEntries[entry.userId] == nil {
            foodEntries[entry.userId] = []
        }
        foodEntries[entry.userId]?.append(entry)
        return entry
    }
    
    func updateFoodEntry(_ entry: FoodEntry) -> FoodEntry {
        guard var entries = foodEntries[entry.userId] else {
            return entry
        }
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
            foodEntries[entry.userId] = entries
        }
        return entry
    }
    
    func deleteFoodEntry(_ entry: FoodEntry) {
        guard var entries = foodEntries[entry.userId] else { return }
        entries.removeAll { $0.id == entry.id }
        foodEntries[entry.userId] = entries
    }
    
    // MARK: - Goal Operations
    
    func getActiveGoal(userId: String) -> DailyGoal? {
        return goals[userId]
    }
    
    func createGoal(_ goal: DailyGoal) -> DailyGoal {
        goals[goal.userId] = goal
        return goal
    }
    
    func updateGoal(_ goal: DailyGoal) -> DailyGoal {
        goals[goal.userId] = goal
        return goal
    }
}

