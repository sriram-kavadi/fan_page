#!/bin/bash
set -e

echo "🚀 ==============================================="
echo "🚀 Rathnaveri Kavitha Official Fan Page - Vercel Build"
echo "🚀 ==============================================="

# 1. Configure Git for CI environments
git config --global --add safe.directory "*" || true

# 2. Install or update Flutter SDK
if [ ! -d "flutter" ]; then
  echo "📦 Cloning Flutter SDK (stable branch)..."
  git clone --depth 1 --branch stable https://github.com/flutter/flutter.git
else
  echo "📦 Existing Flutter directory found. Updating..."
  cd flutter && git pull && cd ..
fi

# 3. Add Flutter to PATH & configure CI environment
export PATH="$PATH:$(pwd)/flutter/bin"
export FLUTTER_SUPPRESS_ANALYTICS=true

echo "🔧 Flutter Version Info:"
flutter --version

echo "⚙️ Enabling web support..."
flutter config --enable-web --no-analytics

echo "📥 Getting dependencies..."
flutter pub get

echo "🏗️ Building Flutter Web release bundle..."
flutter build web --release

echo "✅ Build completed successfully! Output directory: build/web"
