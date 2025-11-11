# FitAI iOS App - Development Plan

## Project Overview
FitAI is an iOS calorie tracking application that uses AI to analyze photos of food and automatically extract macronutrient information (calories, protein, carbs, fats). Users can set weight goals and daily calorie intake/outtake targets, track their progress daily, and view historical data to see which days they reached their goals.

## Tech Stack

### Frontend
- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Async/Await**: Swift Concurrency
- **Networking**: URLSession (or Alamofire if needed)

### Backend & Services
- **Database**: [Choose one: Supabase (PostgreSQL) OR Firebase (Firestore)]
- **Authentication**: [Supabase Auth OR Firebase Auth]
- **Storage**: [Supabase Storage OR Firebase Storage] - For food photos
- **Backend API**: [Supabase REST API OR Firebase Cloud Functions]
- **AI/ML Services**: 
  - OpenAI GPT-4 Vision API OR
  - Google Cloud Vision API OR
  - Custom ML model (Core ML) OR
  - Food recognition API (e.g., Foodvisor, Spoonacular)

### Image Processing
- **Camera**: AVFoundation for photo capture
- **Image Processing**: Core Image, Vision Framework
- **Photo Storage**: Local cache + Cloud storage

### Development Tools
- **IDE**: Xcode
- **Version Control**: Git
- **Package Manager**: Swift Package Manager (SPM)
- **Dependencies**: [To be added as needed]

## Architecture

### Project Structure
```
FitAI/
├── FitAI/
│   ├── App/
│   │   ├── FitAIApp.swift
│   │   └── AppConfig.swift
│   ├── Models/
│   │   ├── User.swift
│   │   ├── FoodEntry.swift
│   │   ├── DailyGoal.swift
│   │   ├── MacroNutrients.swift
│   │   └── Photo.swift
│   ├── Views/
│   │   ├── Authentication/
│   │   │   ├── LoginView.swift
│   │   │   └── SignUpView.swift
│   │   ├── Home/
│   │   │   └── HomeView.swift
│   │   ├── Camera/
│   │   │   └── CameraView.swift
│   │   ├── FoodEntry/
│   │   │   ├── FoodEntryListView.swift
│   │   │   └── FoodEntryDetailView.swift
│   │   ├── Goals/
│   │   │   ├── GoalsView.swift
│   │   │   └── SetGoalsView.swift
│   │   ├── History/
│   │   │   └── HistoryView.swift
│   │   └── Profile/
│   │       └── ProfileView.swift
│   ├── ViewModels/
│   │   ├── AuthViewModel.swift
│   │   ├── HomeViewModel.swift
│   │   ├── CameraViewModel.swift
│   │   ├── FoodEntryViewModel.swift
│   │   ├── GoalsViewModel.swift
│   │   └── HistoryViewModel.swift
│   ├── Services/
│   │   ├── AuthService.swift
│   │   ├── DatabaseService.swift
│   │   ├── NetworkService.swift
│   │   ├── AIService.swift
│   │   ├── PhotoService.swift
│   │   └── GoalTrackingService.swift
│   ├── Utilities/
│   │   ├── Extensions/
│   │   └── Helpers/
│   └── Resources/
│       ├── Assets.xcassets
│       └── Info.plist
├── Tests/
└── PLAN.md
```

## Core Features

### Phase 1: Foundation
- [x] Project setup and configuration
- [x] Backend service selection and setup (Supabase) - **Supabase project configured**
  - [x] Mock data service for development
  - [x] Supabase project setup
  - [x] Supabase configuration
- [x] AI service selection and setup (OpenAI/Food API) - Mock implementation ready
- [x] Basic app structure and navigation
- [x] Authentication system
  - [x] Sign up (Supabase)
  - [x] Sign in (Supabase)
  - [x] Sign out
  - [ ] Password reset
  - [x] Session management (local storage)

### Phase 2: Database Integration & User Goals
- [x] Database schema design
- [x] Database service implementation - **Complete: Supabase integration active**
  - [x] Mock data service implemented (for testing)
  - [x] Supabase backend setup
  - [x] Supabase service integration
- [x] User profile setup - Models ready
- [x] Goal setting system - Models and service methods ready
  - [x] Weight goal (target weight) - Model supports it
  - [x] Daily calorie intake goal - Model supports it
  - [x] Daily calorie deficit/surplus goal - Model supports it
  - [x] Macro targets (protein, carbs, fats) - Model supports it
- [x] CRUD operations for goals - Service methods implemented and connected to Supabase
- [x] Data synchronization with Supabase backend
- [ ] Offline support (if applicable) - **Pending: Supabase setup**

### Phase 3: Photo Capture & AI Analysis
- [x] Camera integration
  - [x] Photo capture from camera - PhotosPicker supports camera access
  - [x] Photo selection from gallery - PhotosPicker implemented
  - [ ] Image preprocessing and optimization - Basic implementation
- [ ] AI service integration - Mock-only placeholder (real provider pending)
  - [ ] API integration for food recognition - Mock implementation only
  - [ ] Photo upload to AI service - Mock placeholder
  - [x] Parse AI response for food items - `FoodAnalysisResult` model
  - [x] Extract macronutrients (calories, protein, carbs, fats) - Done
  - [ ] Handle multiple food items in one photo - Single item for now
  - [x] Error handling for unclear/unrecognized food - Basic error handling
- [x] Food entry creation
  - [x] Manual editing of AI-detected food - Can edit in AddFoodEntryView
  - [x] Manual food entry option - Full manual entry form
  - [ ] Save food entries with photos - Upload & storage integration pending
  - [x] Associate food entries with meals (breakfast, lunch, dinner, snack) - Meal type selector

### Phase 4: Daily Tracking & Progress
- [x] Daily tracking dashboard
  - [x] Display current day's food entries
  - [x] Show calorie consumption vs. goal
  - [x] Show macro breakdown (protein, carbs, fats)
  - [x] Visual progress indicators (progress bars, charts) - Progress bars implemented
  - [x] Remaining calories display
- [x] Real-time goal tracking
  - [x] Calculate daily totals from food entries
  - [x] Compare against daily goals
  - [x] Mark day as goal achieved/not achieved
  - [ ] Push notifications for goal milestones (optional)

### Phase 5: History & Analytics
- [ ] Historical data view - Calendar and filtering pending (list & detail in place)
  - [ ] Calendar view of past days
  - [ ] Visual indicators for goal achievement (green/red indicators)
  - [ ] Filter by date range
  - [x] View detailed daily breakdown
- [ ] Statistics and insights
  - [ ] Weekly/monthly averages
  - [ ] Goal achievement rate
  - [ ] Weight progress tracking
  - [ ] Macro distribution trends
  - [ ] Charts and graphs

### Phase 6: Enhanced Features
- [ ] Web view integration (WKWebView) - Future
- [ ] Barcode scanning for packaged foods
- [ ] Recipe import and analysis
- [ ] Meal planning
- [ ] Social sharing
- [ ] Export data (CSV, PDF)

## Database Schema

### Users Table
- id (UUID) - Primary Key
- email (String) - Unique
- password_hash (String)
- name (String, optional)
- current_weight (Float, optional)
- target_weight (Float, optional)
- height (Float, optional)
- date_of_birth (Date, optional)
- activity_level (String, optional)
- created_at (Timestamp)
- updated_at (Timestamp)

### User Goals Table
- id (UUID) - Primary Key
- user_id (UUID) - Foreign Key -> Users
- daily_calorie_goal (Integer)
- daily_protein_goal (Integer, grams)
- daily_carb_goal (Integer, grams)
- daily_fat_goal (Integer, grams)
- calorie_deficit_goal (Integer, optional) - For weight loss
- calorie_surplus_goal (Integer, optional) - For weight gain
- is_active (Boolean) - Only one active goal per user
- created_at (Timestamp)
- updated_at (Timestamp)

### Food Entries Table
- id (UUID) - Primary Key
- user_id (UUID) - Foreign Key -> Users
- date (Date) - The day this food was consumed
- meal_type (String) - breakfast, lunch, dinner, snack
- food_name (String)
- calories (Float)
- protein (Float, grams)
- carbs (Float, grams)
- fat (Float, grams)
- serving_size (String, optional)
- photo_url (String, optional) - Reference to stored photo
- ai_analyzed (Boolean) - Whether this was analyzed by AI
- ai_confidence (Float, optional) - Confidence score from AI
- notes (Text, optional)
- created_at (Timestamp)
- updated_at (Timestamp)

### Daily Summaries Table
- id (UUID) - Primary Key
- user_id (UUID) - Foreign Key -> Users
- date (Date) - Unique per user per date
- total_calories (Float)
- total_protein (Float)
- total_carbs (Float)
- total_fat (Float)
- goal_achieved (Boolean) - Whether daily calorie goal was met
- calories_remaining (Float) - Calories left to reach goal
- created_at (Timestamp)
- updated_at (Timestamp)

### Photos Table
- id (UUID) - Primary Key
- user_id (UUID) - Foreign Key -> Users
- food_entry_id (UUID, optional) - Foreign Key -> Food Entries
- storage_url (String) - Cloud storage URL
- local_path (String, optional) - Local cache path
- file_size (Integer)
- mime_type (String)
- created_at (Timestamp)

### Weight Tracking Table
- id (UUID) - Primary Key
- user_id (UUID) - Foreign Key -> Users
- weight (Float)
- date (Date)
- notes (Text, optional)
- created_at (Timestamp)

## User Flow

### Onboarding Flow
1. User opens app
2. If not authenticated, show login/sign up screen
3. User signs up or logs in
4. On first login, prompt user to set goals:
   - Current weight
   - Target weight
   - Daily calorie goal
   - Macro targets (optional)
5. Navigate to home screen

### Daily Food Logging Flow
1. User opens app (home screen shows today's progress)
2. User taps "Add Food" button
3. User takes photo of food or selects from gallery
4. Photo is uploaded and analyzed by AI
5. AI returns food items and macros
6. User reviews and edits if needed
7. User selects meal type (breakfast, lunch, dinner, snack)
8. User confirms and saves food entry
9. Home screen updates with new totals
10. Progress bars update to show goal progress

### Goal Tracking Flow
1. User views home screen (daily dashboard)
2. See current calorie intake vs. goal
3. See macro breakdown (protein, carbs, fats)
4. See remaining calories for the day
5. At end of day, system automatically marks goal as achieved/not achieved
6. User can view history to see past days' performance

### History View Flow
1. User navigates to History tab
2. See calendar view with color-coded days (green = goal achieved, red = not achieved)
3. Tap on any day to see detailed breakdown
4. View food entries for that day
5. See totals and goal comparison
6. Filter by date range or view statistics

## Authentication Flow

1. **Sign Up**
   - User enters email and password
   - Validate input
   - Create account via backend service
   - Store session token
   - Navigate to goal setup (first time) or home screen

2. **Sign In**
   - User enters email and password
   - Authenticate via backend service
   - Store session token
   - Navigate to home screen

3. **Sign Out**
   - Clear session token
   - Clear local data (optional)
   - Navigate to login screen

4. **Session Management**
   - Check for valid session on app launch
   - Auto-refresh tokens if needed
   - Handle expired sessions

## AI Food Analysis Workflow

### Photo Analysis Flow
1. **Photo Capture/Selection**
   - User takes photo or selects from gallery
   - Validate photo quality and size
   - Compress/optimize image if needed

2. **Photo Upload**
   - Upload photo to cloud storage
   - Get storage URL
   - Store photo metadata in database

3. **AI Analysis**
   - Send photo to AI service (OpenAI Vision API or Food API)
   - Include prompt for food recognition and macro extraction
   - Handle API response and errors
   - Parse JSON response for food items

4. **Macro Extraction**
   - Extract food name(s)
   - Extract calories per serving
   - Extract macronutrients (protein, carbs, fats)
   - Extract serving size information
   - Handle multiple food items in one photo

5. **User Confirmation**
   - Display AI-detected food items
   - Allow user to edit/confirm food name
   - Allow user to adjust serving size
   - Allow user to manually edit macros
   - Save food entry to database

### AI Service Options
- **OpenAI GPT-4 Vision**: Most flexible, can analyze complex meals
- **Food Recognition APIs**: Specialized for food (Foodvisor, Spoonacular)
- **Custom ML Model**: Train Core ML model for offline analysis
- **Hybrid Approach**: Use API for accuracy, cache results for common foods

### Error Handling
- Handle unclear/unrecognized food photos
- Provide manual entry fallback
- Show confidence scores to users
- Allow retry with different photo
- Cache common foods to reduce API calls

## Web View Integration (Future)

### Implementation Plan
- Use WKWebView for web content
- Support for navigation controls
- JavaScript bridge if needed
- Handle authentication state in web views
- Security considerations (HTTPS only, content security)

## Development Phases

### Phase 1: Setup & Authentication (Week 1-2)
- [x] Initialize Xcode project with SwiftUI
- [x] Set up backend service (Supabase) - Supabase integration active
- [x] Set up AI service (OpenAI/Food API) - Mock implementation ready
- [x] Implement authentication flows (sign up, sign in, sign out)
- [x] Create basic navigation structure (TabView)
- [x] Set up project structure and folder organization

### Phase 2: Database Schema & User Goals (Week 2-3)
- [x] Design and implement database schema - Models created
- [x] Create database service layer - Supabase + mock services available
  - [x] DatabaseService with mock data (for development)
  - [x] Supabase service wrapper
  - [x] Supabase database tables creation
- [x] Implement user profile management - User model and ProfileView
- [x] Build goal setting UI and functionality - Goals view + sheet live
- [x] Allow users to set weight goals and daily calorie targets - Models support it
- [x] Store and retrieve user goals - Supabase-backed
  - [x] Service methods implemented
  - [x] Supabase RLS policies
  - [x] Supabase API integration

### Phase 3: Camera & Photo Integration (Week 3-4)
- [x] Implement camera access and permissions - PhotosPicker handles this
- [x] Build camera view for photo capture - PhotosPicker in AddFoodEntryView
- [x] Implement photo selection from gallery - PhotosPicker implemented
- [ ] Set up photo storage (local cache + cloud storage) - PhotoService exists but needs implementation
- [ ] Create photo service for upload/download - PhotoService exists but needs implementation

### Phase 4: AI Food Analysis (Week 4-5)
- [ ] Integrate AI service API - Mock placeholder, real provider pending
- [ ] Implement photo upload to AI service - Mock placeholder
- [x] Parse AI response for food items and macros - `FoodAnalysisResult` model
- [ ] Handle multiple food items in single photo - Single item for now
- [x] Implement error handling for unrecognized food - Basic error handling
- [x] Add manual editing capability for AI results - Can edit in AddFoodEntryView
- [x] Allow manual food entry as fallback - Full manual entry form

### Phase 5: Food Entry & Daily Tracking (Week 5-6)
- [x] Create food entry models and views - FoodEntry model and AddFoodEntryView
- [x] Implement food entry creation and storage - DatabaseService methods
- [x] Build daily tracking dashboard - HomeView with all components
- [x] Calculate daily totals (calories, macros) - GoalTrackingService
- [x] Compare against daily goals - HomeViewModel calculations
- [x] Display progress indicators and remaining calories - Progress bars and displays
- [x] Mark days as goal achieved/not achieved - isGoalAchieved computed property

### Phase 6: History & Analytics (Week 6-7)
- Build historical data view (calendar)
- Implement visual indicators for goal achievement
- Create daily breakdown view
- Build statistics and analytics
- Implement charts and graphs
- Add filtering by date range

### Phase 7: Polish & Testing (Week 7-8)
- UI/UX improvements
- Error handling and user feedback
- Loading states and animations
- Unit tests for ViewModels and Services
- Integration tests for API calls
- UI tests for critical flows
- Beta testing and bug fixes

### Phase 8: Enhanced Features (Future)
- Web view integration (WKWebView)
- Barcode scanning for packaged foods
- Recipe import and analysis
- Meal planning
- Social sharing
- Export data functionality
- Push notifications for goal reminders

## Security Considerations

- [ ] Secure API key storage (Keychain for sensitive keys)
- [ ] HTTPS only for network requests
- [ ] Token encryption/secure storage (Keychain)
- [x] Input validation (email, password, food entries) - Basic validation in AuthViewModel
- [ ] SQL injection prevention (use parameterized queries)
- [ ] XSS prevention (for web views)
- [ ] Photo privacy and storage security
  - [ ] Encrypt photos in storage
  - [ ] User-specific photo access controls
  - [ ] Secure photo URLs with expiration
  - [ ] Comply with data privacy regulations (GDPR, CCPA)
- [ ] AI service security
  - [ ] Secure API keys for AI services
  - [ ] Rate limiting for API calls
  - [ ] Handle sensitive user data in AI requests
  - [ ] User consent for photo analysis
- [ ] User data protection
  - [ ] Encrypt sensitive user data
  - [ ] Secure password hashing
  - [ ] Regular security audits

## Testing Strategy

- [ ] Unit tests for ViewModels
- [ ] Unit tests for Services
  - [ ] AuthService tests
  - [ ] DatabaseService tests
  - [ ] AIService tests (mock API responses)
  - [ ] PhotoService tests
  - [ ] GoalTrackingService tests
- [ ] Integration tests for API calls
  - [ ] Backend API integration tests
  - [ ] AI service integration tests (with test photos)
  - [ ] Photo upload/download tests
- [ ] UI tests for critical flows
  - [ ] Authentication flow
  - [ ] Photo capture and analysis flow
  - [ ] Food entry creation
  - [ ] Goal tracking
  - [ ] History view
- [ ] Photo analysis accuracy testing
  - [ ] Test with various food types
  - [ ] Test with multiple foods in one photo
  - [ ] Test error handling for unclear photos
- [ ] Performance testing
  - [ ] Photo upload performance
  - [ ] AI analysis response time
  - [ ] Database query performance
- [ ] Manual testing checklist
  - [ ] Test on different iOS devices
  - [ ] Test with various lighting conditions
  - [ ] Test offline functionality
  - [ ] Test goal tracking accuracy

## Deployment

### App Store Requirements
- [ ] App icons and launch screen
- [ ] Privacy policy
- [ ] Terms of service
- [ ] App Store listing content
- [ ] Screenshots and marketing materials

### Build Configuration
- [ ] Development environment
- [ ] Staging environment
- [ ] Production environment
- [ ] App signing and certificates

## Future Considerations

### Platform Expansion
- [ ] Android version (if needed)
- [ ] Web application
- [ ] iPad optimization
- [ ] Apple Watch app (quick food logging)

### Feature Enhancements
- [ ] Barcode scanning for packaged foods
- [ ] Recipe import and analysis
- [ ] Meal planning and meal prep
- [ ] Social features (share meals, follow friends)
- [ ] Nutritionist/coach integration
- [ ] Integration with fitness trackers (Apple Health, Fitbit)
- [ ] Water intake tracking
- [ ] Exercise calorie tracking
- [ ] Meal timing and intermittent fasting support

### Monetization (if applicable)
- [ ] In-app purchases for premium features
- [ ] Subscription model for advanced analytics
- [ ] Ad-supported free tier

### Analytics & Growth
- [ ] Analytics integration (Firebase Analytics, Mixpanel)
- [ ] Push notifications for goal reminders
- [ ] A/B testing for features
- [ ] User feedback and ratings system

## Notes

- **Mock Data Service**: Implemented `MockDataService` for testing and development. All services check `AppConfig.useMockData` before making network calls so the app can run entirely offline for demos.
- **Backend**: **Supabase integration is active in the app.**
  - Supabase service wrapper created (`SupabaseService.swift`)
  - Database schema SQL created (`supabase/schema.sql`)
  - Setup guide created (`SUPABASE_SETUP.md`)
  - App services now read/write through Supabase endpoints
- **Demo Credentials**: `demo@fitai.com` / `demo123` - Pre-populated with sample food entries and goals (mock data)
- **AI Service**: Currently using mock implementation that returns random food items. Ready for real AI service integration (OpenAI GPT-4 Vision, etc.)
- **Architecture**: MVVM pattern with SwiftUI. All ViewModels are marked with `@MainActor` for thread safety.

### Known Issues
- Password reset functionality not yet implemented
- Photo storage flows depend on Supabase bucket configuration and UI surfacing
- History calendar/analytics UI still outstanding
- Multiple food items in single photo not yet supported

### Completed Features
- ✅ Full authentication flow (sign up, sign in, sign out)
- ✅ Session management with UserDefaults
- ✅ Food entry creation (manual and AI photo analysis)
- ✅ Daily tracking dashboard with progress indicators
- ✅ Macro tracking and goal comparison
- ✅ Meal type association (breakfast, lunch, dinner, snack)
- ✅ Real-time data updates after adding entries

## Resources

### Documentation
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Swift Documentation](https://swift.org/documentation/)
- [Supabase Documentation](https://supabase.com/docs) OR [Firebase Documentation](https://firebase.google.com/docs)
- [OpenAI API Documentation](https://platform.openai.com/docs) (for GPT-4 Vision)
- [AVFoundation Documentation](https://developer.apple.com/documentation/avfoundation) (for camera)
- [Core Image Documentation](https://developer.apple.com/documentation/coreimage) (for image processing)
- [Vision Framework Documentation](https://developer.apple.com/documentation/vision) (for image analysis)

### AI Service Options
- [OpenAI GPT-4 Vision API](https://platform.openai.com/docs/guides/vision)
- [Google Cloud Vision API](https://cloud.google.com/vision/docs)
- [Foodvisor API](https://www.foodvisor.io/en/api/)
- [Spoonacular API](https://spoonacular.com/food-api)
- [USDA Food Data Central API](https://fdc.nal.usda.gov/api-guide.html)

### Learning Resources
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [MVVM Pattern in SwiftUI](https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project)
- [Swift Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [iOS Camera Tutorials](https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture)
- [Core ML Documentation](https://developer.apple.com/documentation/coreml) (for custom ML models)

---

**Last Updated**: November 2025
**Version**: 1.0.0

## Progress Summary

### Completed Phases
- ✅ **Phase 1: Foundation** - Complete
- ✅ **Phase 2: Database Integration & User Goals** - Supabase-powered flows live
- ✅ **Phase 3: Photo Capture & AI Analysis** - Mock AI + photo flows in place (storage polish pending)
- ✅ **Phase 4: Daily Tracking & Progress** - Complete with Supabase data
- ✅ **Phase 5: Food Entry & Daily Tracking** - Complete with Supabase data

### Current Status
- ✅ Supabase authentication and database calls enabled in-app
- ✅ Mock data service still available for offline demos
- ✅ Goals view + editing connected to Supabase data
- ✅ History list and detail views reading from Supabase
- 🚧 AI service still mock-only (needs real provider)
- 🚧 Photo storage requires Supabase bucket configuration and UI surfacing
- 🚧 Analytics/calendar visualizations pending

### Next Steps
1. **Integrate Real AI Service**
   - Hook `AIService` into selected provider (OpenAI / Food API)
   - Support multi-item recognition and improved error states
2. **Finalize Photo Storage Experience**
   - Configure Supabase storage bucket policies
   - Persist photo URLs and surface images in UI
3. **History & Analytics Enhancements (Phase 5)**
   - Calendar view with goal achievement indicators
   - Trend charts and filters
4. **Implement Password Reset**
5. **Plan Offline Caching Strategy (if required)**

