//
//  SignUpView.swift
//  FitAI
//
//  User sign up view
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var name = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Name Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Name (Optional)")
                    .font(.headline)
                    .foregroundColor(.white)
                
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.name)
            }
            .padding(.horizontal, 40)
            
            // Email Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.headline)
                    .foregroundColor(.white)
                
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
            }
            .padding(.horizontal, 40)
            
            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.headline)
                    .foregroundColor(.white)
                
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.newPassword)
            }
            .padding(.horizontal, 40)
            
            // Confirm Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Confirm Password")
                    .font(.headline)
                    .foregroundColor(.white)
                
                SecureField("Confirm your password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.newPassword)
            }
            .padding(.horizontal, 40)
            
            // Sign Up Button
            Button(action: {
                signUp()
            }) {
                HStack {
                    if authViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .padding(.top, 10)
            .disabled(authViewModel.isLoading || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
        }
        .alert("Sign Up", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .onChange(of: authViewModel.errorMessage) { error in
            if let error = error {
                alertMessage = error
                showAlert = true
            }
        }
    }
    
    private func signUp() {
        // Validate passwords match
        guard password == confirmPassword else {
            alertMessage = "Passwords do not match"
            showAlert = true
            return
        }
        
        // Validate password length
        guard password.count >= AppConfig.minPasswordLength else {
            alertMessage = "Password must be at least \(AppConfig.minPasswordLength) characters"
            showAlert = true
            return
        }
        
        Task {
            await authViewModel.signUp(
                email: email,
                password: password,
                name: name.isEmpty ? nil : name
            )
            
            if let error = authViewModel.errorMessage {
                alertMessage = error
                showAlert = true
            } else {
                alertMessage = "Account created successfully! Please check your email for verification."
                showAlert = true
            }
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}

