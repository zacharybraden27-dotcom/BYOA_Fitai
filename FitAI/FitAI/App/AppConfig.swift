//
//  AppConfig.swift
//  FitAI
//
//  App configuration and constants
//

import Foundation

struct AppConfig {
    // Backend Configuration
    // TODO: Replace with your actual backend URL
    static let backendURL = "https://your-backend-url.com"
    
    // API Keys
    // TODO: Move to secure storage (Keychain) in production
    static let apiKey = "your-api-key"
    
    // AI Service Configuration
    // TODO: Replace with your actual AI service API key
    static let aiServiceAPIKey = "your-ai-api-key"
    static let aiServiceURL = "https://api.openai.com/v1" // Example: OpenAI
    
    // Storage Configuration
    static let photoStorageBucket = "food-photos"
    
    // App Settings
    static let appName = "FitAI"
    static let appVersion = "1.0.0"
    
    // Validation Rules
    static let minPasswordLength = 6
    static let maxPhotoSizeMB = 10
    
    // Mock/Demo Mode
    static let useMockData = true // Set to false when backend is ready
}

