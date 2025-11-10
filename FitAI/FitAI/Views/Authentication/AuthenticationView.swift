//
//  AuthenticationView.swift
//  FitAI
//
//  Authentication view container
//

import SwiftUI

struct AuthenticationView: View {
    @State private var isLoginMode = true
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // App Title
                VStack(spacing: 10) {
                    Text("FitAI")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Track your calories with AI")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.top, 60)
                
                // Login/Sign Up Toggle
                Picker("Mode", selection: $isLoginMode) {
                    Text("Login").tag(true)
                    Text("Sign Up").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 40)
                
                // Login or Sign Up View
                if isLoginMode {
                    LoginView()
                } else {
                    SignUpView()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AuthViewModel())
}

