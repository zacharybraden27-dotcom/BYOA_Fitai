//
//  AuthService.swift
//  FitAI
//
//  Authentication service
//

import Foundation

struct SignUpRequest: Codable {
    let email: String
    let password: String
    let name: String?
}

struct SignInRequest: Codable {
    let email: String
    let password: String
}

struct AuthResponse: Codable {
    let user: User
    let token: String
}

class AuthService {
    static let shared = AuthService()
    
    private let networkService = NetworkService.shared
    private let mockDataService = MockDataService.shared
    private let tokenKey = "auth_token"
    private let userKey = "current_user"
    
    private init() {}
    
    // Sign up
    func signUp(email: String, password: String, name: String? = nil) async throws -> AuthResponse {
        // Always check mock mode first - never make network calls if mock mode is enabled
        if AppConfig.useMockData {
            // Mock sign up
            let user = User(
                id: UUID().uuidString,
                email: email,
                name: name ?? "New User",
                currentWeight: nil,
                targetWeight: nil,
                height: nil,
                dateOfBirth: nil,
                activityLevel: nil,
                createdAt: Date(),
                updatedAt: Date()
            )
            let token = "mock_token_\(UUID().uuidString)"
            let response = AuthResponse(user: user, token: token)
            saveToken(response.token)
            saveUser(response.user)
            return response
        }
        
        let request = SignUpRequest(email: email, password: password, name: name)
        // TODO: Replace with actual API endpoint
        let response: AuthResponse = try await networkService.post(
            endpoint: "/auth/signup",
            body: request
        )
        
        // Store token and user
        saveToken(response.token)
        saveUser(response.user)
        
        return response
    }
    
    // Sign in
    func signIn(email: String, password: String) async throws -> AuthResponse {
        // Always check mock mode first - never make network calls if mock mode is enabled
        if AppConfig.useMockData {
            // Mock sign in - accept any credentials, but use demo user for demo@fitai.com
            let user: User
            if email == MockDataService.mockEmail {
                // Use the pre-populated demo user
                user = mockDataService.getUser(byEmail: email) ?? User(
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
            } else {
                // Create a new user for any other email
                user = User(
                    id: UUID().uuidString,
                    email: email,
                    name: email.components(separatedBy: "@").first?.capitalized ?? "User",
                    currentWeight: nil,
                    targetWeight: nil,
                    height: nil,
                    dateOfBirth: nil,
                    activityLevel: nil,
                    createdAt: Date(),
                    updatedAt: Date()
                )
            }
            let token = "mock_token_\(user.id)"
            let response = AuthResponse(user: user, token: token)
            saveToken(response.token)
            saveUser(response.user)
            return response
        }
        
        let request = SignInRequest(email: email, password: password)
        // TODO: Replace with actual API endpoint
        let response: AuthResponse = try await networkService.post(
            endpoint: "/auth/signin",
            body: request
        )
        
        // Store token and user
        saveToken(response.token)
        saveUser(response.user)
        
        return response
    }
    
    // Sign out
    func signOut() {
        removeToken()
        removeUser()
    }
    
    // Get current user
    func getCurrentUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userKey) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(User.self, from: data)
        } catch {
            return nil
        }
    }
    
    // Get auth token
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    // Check if user is authenticated
    func isAuthenticated() -> Bool {
        return getToken() != nil && getCurrentUser() != nil
    }
    
    // Get auth headers
    func getAuthHeaders() -> [String: String] {
        guard let token = getToken() else {
            return [:]
        }
        return ["Authorization": "Bearer \(token)"]
    }
    
    // Private helper methods
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    private func removeToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    private func saveUser(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: userKey)
        } catch {
            print("Error saving user: \(error)")
        }
    }
    
    private func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}
