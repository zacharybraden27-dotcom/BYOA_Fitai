# FitAI - iOS Calorie Tracking App

FitAI is an iOS calorie tracking application that uses AI to analyze photos of food and automatically extract macronutrient information.

## Project Structure

```
FitAI/
├── FitAI/
│   ├── App/
│   │   ├── FitAIApp.swift          # App entry point
│   │   └── AppConfig.swift         # App configuration
│   ├── Models/
│   │   ├── User.swift
│   │   ├── FoodEntry.swift
│   │   ├── DailyGoal.swift
│   │   ├── MacroNutrients.swift
│   │   ├── Photo.swift
│   │   └── FoodAnalysisResult.swift
│   ├── Views/
│   │   ├── ContentView.swift
│   │   ├── MainTabView.swift
│   │   ├── Authentication/
│   │   │   ├── AuthenticationView.swift
│   │   │   ├── LoginView.swift
│   │   │   └── SignUpView.swift
│   │   ├── Home/
│   │   │   └── HomeView.swift
│   │   ├── Profile/
│   │   │   └── ProfileView.swift
│   │   └── [Other views - placeholder]
│   ├── ViewModels/
│   │   ├── AuthViewModel.swift
│   │   └── HomeViewModel.swift
│   ├── Services/
│   │   ├── AuthService.swift
│   │   ├── DatabaseService.swift
│   │   ├── NetworkService.swift
│   │   ├── AIService.swift
│   │   ├── PhotoService.swift
│   │   └── GoalTrackingService.swift
│   └── Resources/
│       └── Assets.xcassets
```

## Setup Instructions

### 1. Create Xcode Project

1. Open Xcode
2. Create a new project:
   - Choose "iOS" → "App"
   - Product Name: `FitAI`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Storage: `None` (we'll use our own structure)

### 2. Import Existing Files

1. In Xcode, right-click on the project navigator
2. Select "Add Files to FitAI..."
3. Navigate to the `FitAI/FitAI` directory
4. Select all folders (App, Models, Views, ViewModels, Services)
5. Make sure "Create groups" is selected (not "Create folder references")
6. Check "Copy items if needed" if the files aren't already in the project directory
7. Click "Add"

### 3. Configure App Settings

1. In Xcode, select the project in the navigator
2. Go to the "Signing & Capabilities" tab
3. Select your development team
4. Set the Bundle Identifier (e.g., `com.yourcompany.FitAI`)

### 4. Update AppConfig.swift

1. Open `App/AppConfig.swift`
2. Update the following with your actual values:
   - `backendURL`: Your backend API URL
   - `apiKey`: Your API key (move to Keychain in production)
   - `aiServiceAPIKey`: Your AI service API key
   - `aiServiceURL`: Your AI service URL

### 5. Build and Run

1. Select a simulator or device
2. Press Cmd+R to build and run
3. The app should launch with the authentication screen

## Development Phases

### Phase 1: Foundation ✅
- [x] Project structure
- [x] Authentication system (UI)
- [x] Basic navigation
- [ ] Backend integration (requires backend setup)
- [ ] AI service integration (requires API keys)

### Phase 2: Database Integration & User Goals
- [ ] Database schema implementation
- [ ] Goal setting UI and functionality
- [ ] User profile management

### Phase 3: Photo Capture & AI Analysis
- [ ] Camera integration
- [ ] Photo selection from gallery
- [ ] AI service integration
- [ ] Food analysis workflow

### Phase 4: Daily Tracking & Progress
- [ ] Daily tracking dashboard
- [ ] Real-time goal tracking
- [ ] Progress indicators

### Phase 5: History & Analytics
- [ ] Historical data view
- [ ] Statistics and insights
- [ ] Charts and graphs

## Notes

- The authentication service is set up but requires a backend API to function
- The AI service is a placeholder and needs API integration
- Photo service is a placeholder and needs cloud storage integration
- All services use placeholder endpoints that need to be updated with actual API endpoints

## Next Steps

1. Set up your backend (Supabase or Firebase)
2. Configure API endpoints in `AppConfig.swift`
3. Update service endpoints in `AuthService.swift`, `DatabaseService.swift`, etc.
4. Test authentication flow
5. Continue with Phase 2 development

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

