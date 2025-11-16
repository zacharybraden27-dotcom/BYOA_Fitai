# Xcode Build Script Setup

This guide explains how to add the build script to Xcode so it automatically reads your `.env` file and generates the Swift configuration file during each build.

## Quick Setup

### Step 1: Add the Build Script to Xcode

1. **Open your project in Xcode**
   - Open `FitAI/FitAI/FitAI/FitAI.xcodeproj`

2. **Select your project in the navigator**
   - Click on the blue "FitAI" project icon at the top

3. **Select the FitAI target**
   - In the main editor area, click on the "FitAI" target (under TARGETS)

4. **Go to Build Phases tab**
   - Click on the "Build Phases" tab at the top

5. **Add a new Run Script Phase**
   - Click the **+** button at the top left of the Build Phases section
   - Select **New Run Script Phase**

6. **Configure the script**
   - **Name**: Name it "Generate Env Config" (optional, for clarity)
   - **Shell**: `/bin/sh` (default)
   - **Script**: Paste the following:

```bash
# Generate Swift config from .env file
"${SRCROOT}/../scripts/generate-env-config.sh"
```

   Or use the absolute path if the relative path doesn't work:

```bash
# Generate Swift config from .env file
SCRIPT_PATH="${SRCROOT}/../scripts/generate-env-config.sh"
if [ -f "$SCRIPT_PATH" ]; then
    bash "$SCRIPT_PATH"
else
    echo "Warning: Build script not found at $SCRIPT_PATH"
fi
```

7. **Move the script phase**
   - **Important**: Drag the "Generate Env Config" phase to be **BEFORE** "Compile Sources"
   - This ensures the Swift file is generated before compilation

8. **Configure script options** (optional but recommended)
   - Uncheck "Show environment variables in build log" (for security)
   - Check "Run script only when installing" can stay **unchecked** (we want it to run on every build)

### Step 2: Verify the Generated File

1. **Build the project**
   - Press **Cmd + B** to build
   - Check the build log for messages like:
     - `🔧 Reading .env file from: ...`
     - `✅ Successfully loaded GEMINI_API_KEY from .env`
     - `✅ Generated .../GeneratedEnvConfig.swift`

2. **Check the generated file**
   - Navigate to `FitAI/FitAI/FitAI/FitAI/App/GeneratedEnvConfig.swift`
   - It should contain your API key (don't commit this if it has your real key!)

### Step 3: Add Generated File to Xcode Project (if needed)

If Xcode doesn't automatically detect the generated file:

1. **Right-click** on the `App` folder in Xcode
2. Select **Add Files to "FitAI"...**
3. Navigate to `FitAI/FitAI/FitAI/FitAI/App/GeneratedEnvConfig.swift`
4. Make sure:
   - ✅ "Copy items if needed" is **unchecked** (file is already in place)
   - ✅ "Create groups" is selected
   - ✅ "FitAI" target is checked
5. Click **Add**

## How It Works

1. **During build**, Xcode runs the script before compiling Swift files
2. The script reads your `.env` file from the project root
3. It generates `GeneratedEnvConfig.swift` with your API key
4. Swift compiles the generated file along with your code
5. `AppConfig.swift` reads the key from `GeneratedEnvConfig`

## Troubleshooting

### Script not running
- Make sure the script phase is **before** "Compile Sources"
- Check that the script path is correct
- Verify the script has execute permissions: `chmod +x scripts/generate-env-config.sh`

### ".env file not found" warning
- Make sure your `.env` file is in the project root (same level as `FitAI` folder)
- Check that `SRCROOT` is set correctly (Xcode sets this automatically)

### API key not being used
- Check that `GeneratedEnvConfig.swift` was generated correctly
- Verify the file is included in the Xcode project and target
- Check the build log for any errors

### Build errors about GeneratedEnvConfig
- Make sure `GeneratedEnvConfig.swift` is added to the Xcode project
- Clean build folder: **Product → Clean Build Folder** (Cmd + Shift + K)
- Rebuild the project

## Alternative: Manual Generation

If you prefer not to use a build script, you can manually run:

```bash
cd "/Users/206741188/BYOA_Projects/04. FitAI "
export SRCROOT="$(pwd)"
bash scripts/generate-env-config.sh
```

Then commit `GeneratedEnvConfig.swift` to git (but remember to use a placeholder key in the committed version).

## Security Notes

- ✅ The `.env` file is in `.gitignore` and won't be committed
- ⚠️ `GeneratedEnvConfig.swift` contains your API key - consider adding it to `.gitignore` if you don't want to commit it
- ✅ The build script runs locally and never uploads your key anywhere

