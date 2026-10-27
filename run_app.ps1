param (
    [string]$Device = "chrome"
)

# Nikhil's Fantasy Studio - App Launch Script
# Automatically ensures build directory is isolated from sync locks

$targetBuild = "$env:LOCALAPPDATA\Fantasy_studio_build"

if (!(Test-Path $targetBuild)) {
    New-Item -ItemType Directory -Path $targetBuild -Force | Out-Null
}

if (!(Test-Path "build")) {
    cmd /c mklink /J "build" "$targetBuild" | Out-Null
}

# Clean any lingering flutter_assets lock before launch
if (Test-Path "build\flutter_assets") {
    Remove-Item -Recurse -Force "build\flutter_assets" -ErrorAction SilentlyContinue | Out-Null
}

Write-Host "🚀 Launching Nikhil's Fantasy Studio on $Device..." -ForegroundColor Cyan

flutter run -d $Device
