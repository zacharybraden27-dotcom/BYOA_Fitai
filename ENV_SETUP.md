# Environment Variables Setup

This project uses a `.env` file to store sensitive configuration like API keys. The build process automatically reads your `.env` file and generates a Swift configuration file.

## Quick Setup

### 1. Create your `.env` file

Your `.env` file should be in the project root (same level as the `FitAI` folder):

```
GEMINI_API_KEY=your-actual-api-key-here
```

### 2. Add Build Script to Xcode (Required)

**See `XCODE_BUILD_SCRIPT_SETUP.md` for detailed instructions.**

Quick steps:
1. Open Xcode project
2. Select **FitAI** target → **Build Phases** tab
3. Click **+** → **New Run Script Phase**
4. Add script: `"${SRCROOT}/../scripts/generate-env-config.sh"`
5. Drag the script phase **before** "Compile Sources"

The build script will automatically:
- Read your `.env` file during each build
- Generate `GeneratedEnvConfig.swift` with your API key
- Make it available to your Swift code

### 3. How It Works

1. **Build script runs** → Reads `.env` file
2. **Generates Swift file** → Creates `GeneratedEnvConfig.swift`
3. **Swift compiles** → Includes the generated config
4. **AppConfig uses it** → `AppConfig.geminiAPIKey` gets the value

### 4. Verify Setup

After adding the build script:
1. Build the project (Cmd + B)
2. Check build log for: `✅ Successfully loaded GEMINI_API_KEY from .env`
3. Verify `GeneratedEnvConfig.swift` was created in the `App` folder

## Security Notes

- ✅ The `.env` file is already in `.gitignore` and won't be committed
- ✅ Never commit your actual API keys to version control
- ✅ Use `.env.example` as a template for other developers
- ⚠️ For production apps, consider using a more secure key management solution

## Getting Your Gemini API Key

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy the key and add it to your `.env` file

