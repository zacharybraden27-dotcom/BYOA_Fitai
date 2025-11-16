#!/bin/bash

# Script to generate Swift configuration file from .env file
# This script runs during Xcode build and creates a Swift file with environment variables

set -e

# Get the project root (where .env file is located)
# SRCROOT is set by Xcode to the project root directory
PROJECT_ROOT="${SRCROOT}"
if [ -z "$PROJECT_ROOT" ]; then
    # Fallback: try to find project root from script location
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"
fi

ENV_FILE="${PROJECT_ROOT}/.env"
OUTPUT_DIR="${PROJECT_ROOT}/FitAI/FitAI/FitAI/FitAI/App"
OUTPUT_FILE="${OUTPUT_DIR}/GeneratedEnvConfig.swift"

# Create output directory if it doesn't exist
mkdir -p "${OUTPUT_DIR}"

# Start generating the Swift file
cat > "${OUTPUT_FILE}" << 'EOF'
//
//  GeneratedEnvConfig.swift
//  FitAI
//
//  AUTO-GENERATED FILE - DO NOT EDIT MANUALLY
//  This file is generated automatically from .env file during build
//

import Foundation

struct GeneratedEnvConfig {
EOF

# Read .env file and generate Swift constants
if [ -f "${ENV_FILE}" ]; then
    echo "🔧 Reading .env file from: ${ENV_FILE}"
    
    GEMINI_KEY_FOUND=false
    
    # Parse .env file and generate Swift properties
    while IFS= read -r line || [ -n "$line" ]; do
        # Skip empty lines and comments
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "${line// }" ]] && continue
        
        # Parse KEY=VALUE format (handles spaces around =)
        if [[ "$line" =~ ^[[:space:]]*([^=]+)[[:space:]]*=[[:space:]]*(.*)$ ]]; then
            KEY="${BASH_REMATCH[1]}"
            VALUE="${BASH_REMATCH[2]}"
            
            # Remove leading/trailing whitespace
            KEY=$(echo "$KEY" | xargs)
            VALUE=$(echo "$VALUE" | xargs)
            
            # Remove quotes if present
            VALUE="${VALUE%\"}"
            VALUE="${VALUE#\"}"
            VALUE="${VALUE%\'}"
            VALUE="${VALUE#\'}"
            
            if [ -n "$KEY" ] && [ -n "$VALUE" ]; then
                # Handle GEMINI_API_KEY specifically
                if [ "$KEY" = "GEMINI_API_KEY" ]; then
                    GEMINI_KEY_FOUND=true
                    # Escape quotes and backslashes in value
                    ESCAPED_VALUE=$(echo "$VALUE" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')
                    echo "    static let geminiApiKey: String? = \"${ESCAPED_VALUE}\"" >> "${OUTPUT_FILE}"
                    echo "    // Generated from .env file" >> "${OUTPUT_FILE}"
                fi
            fi
        fi
    done < "${ENV_FILE}"
    
    if [ "$GEMINI_KEY_FOUND" = false ]; then
        echo "⚠️  Warning: GEMINI_API_KEY not found in .env file"
        echo "    static let geminiApiKey: String? = nil" >> "${OUTPUT_FILE}"
        echo "    // GEMINI_API_KEY not found in .env file" >> "${OUTPUT_FILE}"
    else
        echo "✅ Successfully loaded GEMINI_API_KEY from .env"
    fi
else
    echo "⚠️  Warning: .env file not found at ${ENV_FILE}"
    echo "    static let geminiApiKey: String? = nil" >> "${OUTPUT_FILE}"
    echo "    // .env file not found" >> "${OUTPUT_FILE}"
fi

# Close the struct
cat >> "${OUTPUT_FILE}" << 'EOF'
}
EOF

echo "✅ Generated ${OUTPUT_FILE}"

