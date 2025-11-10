//
//  AppConfig.swift
//  FitAI
//
//  App configuration and constants
//

import Foundation

struct AppConfig {
    // Supabase Configuration
    static let supabaseURL = "https://vjdvozwjmvwkmjfwbvlt.supabase.co"
    static let supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZqZHZvendqbXZ3a21qZndidmx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI3ODg5NzIsImV4cCI6MjA3ODM2NDk3Mn0.MjiIAqw1yRhd3Zi-ruEV2RoJWXPecSw9ENOAkqxSR04"
    static let supabaseServiceKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZqZHZvendqbXZ3a21qZndidmx0Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2Mjc4ODk3MiwiZXhwIjoyMDc4MzY0OTcyfQ.VrEwQ-1iXPRbOS2hk--FL2VcoCO1O3TNAKIGFIkwt2k" // For server-side operations only
    
    // Legacy Backend Configuration (for non-Supabase setups)
    static let backendURL = "https://your-backend-url.com"
    static let apiKey = "your-api-key"
    
    // AI Service Configuration
    // TODO: Replace with your actual AI service API key
    static let aiServiceAPIKey = "your-ai-api-key"
    static let aiServiceURL = "https://api.openai.com/v1" // Example: OpenAI
    
    // Storage Configuration
    static let photoStorageBucket = "food-photos" // Supabase Storage bucket name
    
    // App Settings
    static let appName = "FitAI"
    static let appVersion = "1.0.0"
    
    // Validation Rules
    static let minPasswordLength = 6
    static let maxPhotoSizeMB = 20
    
    // Mock/Demo Mode
    static let useMockData = false // Supabase integration enabled
}

