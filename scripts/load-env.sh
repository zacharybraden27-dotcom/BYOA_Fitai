#!/bin/bash

# Script to load .env file and export environment variables
# This script should be added as a build phase in Xcode

# Find .env file in project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"
ENV_FILE="$PROJECT_ROOT/.env"

# If .env file exists, load it
if [ -f "$ENV_FILE" ]; then
    echo "Loading environment variables from .env file..."
    # Export variables from .env file
    set -a
    source "$ENV_FILE"
    set +a
    echo "Environment variables loaded successfully"
else
    echo "Warning: .env file not found at $ENV_FILE"
    echo "Using environment variables from Xcode scheme or system"
fi

