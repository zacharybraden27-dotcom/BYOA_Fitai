# FitAI - Xcode Setup Guide

## Quick Start

Follow these steps to set up the FitAI project in Xcode:

## Step 1: Create New Xcode Project

1. Open **Xcode**
2. Select **File → New → Project**
3. Choose **iOS → App**
4. Configure:
   - **Product Name**: `FitAI`
   - **Team**: Select your development team
   - **Organization Identifier**: `com.yourcompany` (or your preferred identifier)
   - **Interface**: `SwiftUI`
   - **Language**: `Swift`
   - **Storage**: `None`
   - **Include Tests**: ✓ (optional)
5. Choose a location to save the project
6. Click **Create**

## Step 2: Replace Default Files

1. **Delete** the default `ContentView.swift` that Xcode created (if it exists in the root)
2. The project structure should match the files we've created

## Step 3: Add Files to Xcode Project

Since the files are already created in the file system, you need to add them to the Xcode project:

### Option A: Drag and Drop (Recommended)

1. Open **Finder** and navigate to `/Users/206741188/BYOA_Projects/04. FitAI /FitAI/FitAI/`
2. In **Xcode**, in the Project Navigator, right-click on the `FitAI` folder (or project root)
3. Select **Add Files to "FitAI"...**
4. Navigate to the `FitAI/FitAI` directory
5. Select these folders:
   - `App`
   - `Models`
   - `Views`
   - `ViewModels`
   - `Services`
   - `Utilities`
6. Make sure these options are selected:
   - ✓ **Create groups** (NOT "Create folder references")
   - ✓ **Add to targets: FitAI**
   - ✗ **Copy items if needed** (uncheck if files are already in the project directory)
7. Click **Add**

### Option B: Manual File Addition

If the drag-and-drop method doesn't work:

1. In Xcode Project Navigator, create groups matching the folder structure:
   - `App`
   - `Models`
   - `Views` (with subfolders: `Authentication`, `Home`, `Profile`, etc.)
   - `ViewModels`
   - `Services`
   - `Utilities`

2. For each group, right-click → **Add Files to "FitAI"...**
3. Select the corresponding folder and files
4. Make sure **Create groups** is selected

## Step 4: Verify File Structure

Your Xcode project should look like this:

```
FitAI
├── FitAI
│   ├── App
│   │   ├── FitAIApp.swift
│   │   └── AppConfig.swift
│   ├── Models
│   │   ├── User.swift
│   │   ├── FoodEntry.swift
│   │   ├── DailyGoal.swift
│   │   ├── MacroNutrients.swift
│   │   ├── Photo.swift
│   │   └── FoodAnalysisResult.swift
│   ├── Views
│   │   ├── ContentView.swift
│   │   ├── MainTabView.swift
│   │   ├── Authentication
│   │   │   ├── AuthenticationView.swift
│   │   │   ├── LoginView.swift
│   │   │   └── SignUpView.swift
│   │   ├── Home
│   │   │   └── HomeView.swift
│   │   ├── Profile
│   │   │   └── ProfileView.swift
│   │   └── [Other views...]
│   ├── ViewModels
│   │   ├── AuthViewModel.swift
│   │   └── HomeViewModel.swift
│   ├── Services
│   │   ├── AuthService.swift
│   │   ├── DatabaseService.swift
│   │   ├── NetworkService.swift
│   │   ├── AIService.swift
│   │   ├── PhotoService.swift
│   │   └── GoalTrackingService.swift
│   └── Resources
│       └── Assets.xcassets
└── FitAITests
└── FitAIUITests
```

## Step 5: Configure Build Settings

1. Select the **FitAI** project in the Navigator
2. Select the **FitAI** target
3. Go to **General** tab:
   - **Deployment Info**: iOS 15.0 or later
   - **Supported Destinations**: iPhone, iPad
4. Go to **Signing & Capabilities**:
   - Select your **Team**
   - Verify **Bundle Identifier** is set

## Step 6: Set App Entry Point

1. Make sure `FitAIApp.swift` in the `App` folder is set as the main entry point
2. Xcode should automatically detect the `@main` attribute
3. If you see build errors about multiple `@main` attributes, ensure only `FitAIApp.swift` has it

## Step 7: Update AppConfig

1. Open `App/AppConfig.swift`
2. Update the placeholder values:
   ```swift
   static let backendURL = "https://your-backend-url.com"
   static let apiKey = "your-api-key"
   static let geminiAPIKey = ProcessInfo.processInfo.environment["GEMINI_API_KEY"] ?? "your-gemini-api-key"
   ```
3. **Recommended:** Store your Gemini key in an environment variable instead of hard-coding it. For example, in your Xcode scheme, set `GEMINI_API_KEY` under *Edit Scheme → Run → Arguments → Environment Variables*.

## Step 8: Build and Run

1. Select a **simulator** (e.g., iPhone 15 Pro) or connected device
2. Press **Cmd + R** to build and run
3. The app should launch and show the authentication screen

## Troubleshooting

### Error: "Cannot find 'ContentView' in scope"
- Make sure `ContentView.swift` is added to the Xcode project
- Check that it's included in the FitAI target

### Error: "Multiple commands produce..."
- Clean the build folder: **Product → Clean Build Folder** (Cmd + Shift + K)
- Delete DerivedData: `rm -rf ~/Library/Developer/Xcode/DerivedData/FitAI-*`

### Error: "No such module 'UIKit'"
- This is expected on macOS - the code uses conditional compilation
- Make sure you're building for iOS, not macOS

### Files not appearing in Xcode
- Make sure you selected **Create groups** (blue folder icon), not **Create folder references** (yellow folder icon)
- Try removing and re-adding the files

### Build errors about missing types
- Make sure all files are added to the **FitAI target**
- Check **File Inspector** (right panel) → **Target Membership** → ✓ FitAI

## Next Steps

1. **Configure Backend**: Set up your backend service (Supabase/Firebase)
2. **Update API Endpoints**: Update service endpoints in `AppConfig.swift` and service files
3. **Test Authentication**: Test the sign up and login flow
4. **Continue Development**: Follow the development phases in `PLAN.md`

## Project Status

✅ **Phase 1 Complete**:
- Project structure created
- All models defined
- All services created (with placeholder implementations)
- Authentication UI complete
- Basic navigation set up
- Home view with daily tracking UI

🔄 **Next Phase**: 
- Backend integration
- Database setup
- AI service integration
- Photo capture functionality

## Notes

- The app is currently set up with placeholder API endpoints
- Authentication service requires backend API to function
- AI service requires API key and service integration
- Photo service requires cloud storage setup
- All services are ready for backend integration

