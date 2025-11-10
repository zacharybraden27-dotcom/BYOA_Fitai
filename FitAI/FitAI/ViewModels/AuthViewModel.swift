//
//  AuthViewModel.swift
//  FitAI
//
//  Authentication view model
//

import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentUser: User?
    
    private let authService = AuthService.shared
    
    init() {
        checkAuthenticationStatus()
    }
    
    func checkAuthenticationStatus() {
        isAuthenticated = authService.isAuthenticated()
        if isAuthenticated {
            currentUser = authService.getCurrentUser()
        }
    }
    
    func signUp(email: String, password: String, name: String? = nil) async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Validate input
            guard !email.isEmpty, !password.isEmpty else {
                errorMessage = "Email and password are required"
                isLoading = false
                return
            }
            
            guard password.count >= AppConfig.minPasswordLength else {
                errorMessage = "Password must be at least \(AppConfig.minPasswordLength) characters"
                isLoading = false
                return
            }
            
            guard isValidEmail(email) else {
                errorMessage = "Please enter a valid email address"
                isLoading = false
                return
            }
            
            let response = try await authService.signUp(email: email, password: password, name: name)
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = false
        }
        
        isLoading = false
    }
    
    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Validate input
            guard !email.isEmpty, !password.isEmpty else {
                errorMessage = "Email and password are required"
                isLoading = false
                return
            }
            
            let response = try await authService.signIn(email: email, password: password)
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = false
        }
        
        isLoading = false
    }
    
    func signOut() {
        authService.signOut()
        isAuthenticated = false
        currentUser = nil
        errorMessage = nil
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

