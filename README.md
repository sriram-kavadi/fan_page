# ✦ Nikhil's Fantasy Studio

> **Transform Your Imagination Into Extraordinary Sticker Art**  
> A premium, full-featured digital art and sticker creation studio built with Flutter.

---

## 🌟 Overview & Identity

**Nikhil's Fantasy Studio** is a creative suite engineered for digital artists, designers, and enthusiasts to craft, customize, and export holographic, cosmic, and fantasy sticker art. 

Built with Flutter and styled with a custom design system ("Electric Studio"), the application delivers a modern creative workflow with 30+ categorized sticker templates, 5 themed collectible sticker packs, an interactive multi-layer canvas workspace, real-time transformations (scaling, rotation, repositioning), dynamic background textures, undo/redo history, and a local designs vault.

---

## 🎨 Visual Identity & Design System

- **Brand Name**: Nikhil's Fantasy Studio
- **Tagline**: *Create • Design • Inspire*
- **Primary Color Palette**:
  - `Electric Blue` (`#0A84FF`): Primary interactive elements & highlights
  - `Mint Green` (`#00C896`): Secondary accents & success indicators
  - `Coral Fire` (`#FF6B6B`): Warm highlights & badges
  - `Celestial Gold` (`#FFD700`): Premium star badges & crown accents
  - `Deep Navy / Cosmic Void` (`#0A0E1A`): Sleek dark mode canvas backdrop
  - `Soft Lavender Glass` (`#F0F4FF`): Modern light mode surface
- **Typography**: Google Fonts **Outfit** (Weights 400 to 800)
- **Aesthetic**: Glassmorphic cards, luminous gradients, floating orbs, die-cut sticker borders, glowing halos, and micro-interactions.

---

## 🚀 Key Features

### 1. 🎨 Interactive Sticker Canvas
- **Multi-Element Composition**: Place multiple sticker elements onto a styled canvas workspace.
- **Direct Manipulation**: Tap to select, drag to reposition anywhere on the canvas.
- **Precision Controls**: Scale elements from 0.3x to 4.0x, rotate 360°, and customize layers.
- **Background Switcher**: Choose from Dark Grid, Neon Cosmic, Deep Nebula, Pure Dark, Cyber Dots, Sunset Gradient, or Light Studio.
- **Undo / Redo Architecture**: Full 20-step undo and redo state stack for risk-free editing.
- **Artwork Saving**: Save designs with customized titles to your personal gallery.

### 2. ⚡ 30+ Categorized Sticker Templates
- **Cosmic**: *Galaxy Nova, Solar Flare, Aurora Ring, Moon Phase, Nebula Cloud, Comet Trail*
- **Nature**: *Forest Spirit, Ocean Wave, Cherry Blossom, Thunder Storm, Crystal Snow, Volcano Fire*
- **Fantasy**: *Dragon Scale, Phoenix Flame, Unicorn Magic, Crystal Sword, Magic Portal, Mermaid Tail*
- **Tech**: *Cyber Circuit, Neon Matrix, Pixel Power, AI Nexus, Quantum Bit, Data Stream*
- **Vibes**: *Fire King, Crown Royal, Legend Badge, Chill Wave, Zen Circle, Lucky Star*
- **Multi-Shape Geometries**: Rendered with custom vector painters for Hexagon, Star, Shield, Diamond, Heart, and Circle die-cuts.
- **Instant Search & Category Filters**: Real-time keyword filtering across all categories.

### 3. 📦 Themed Sticker Packs
- 5 comprehensive collectible packs (*Cosmic Explorer*, *Fantasy Realm*, *Nature Force*, *Tech Cyberverse*, *Vibe Nation*).
- Pack download management with dynamic download counters and sticker previews.
- Pack inspection showing individual sticker assets and die-cut previews.

### 4. 📁 My Designs Vault
- Instant gallery of all saved sticker compositions and artworks.
- Favorite designs filter tab.
- Quick actions: load design into studio canvas, duplicate, or delete.

### 5. 🌓 Dual-Theme System
- Seamless dark and light mode toggle with state persistence.
- Fluid transitions and contrast-optimized color palettes.

---

## 📂 Project Architecture

```
nikhils_fantasy_studio/
├── assets/
│   ├── fonts/                         # Bundled Outfit font files (400, 500, 600, 700, 800)
│   ├── illustrations/                 # Hero fantasy illustration & holographic sticker graphics
│   └── images/                        # High-resolution app logo & brand iconography
├── lib/
│   ├── main.dart                      # App entry point, MultiProvider setup & 5-tab MainShell
│   ├── models/
│   │   └── studio_models.dart         # StickerTemplate, CanvasStickerItem, CreatedDesign, StickerPack
│   ├── providers/
│   │   ├── studio_provider.dart       # Core studio state: templates, canvas, undo/redo, packs
│   │   └── theme_provider.dart        # Dynamic dark/light theme switching
│   ├── screens/
│   │   ├── home_screen.dart           # Dashboard with hero header, quick stats & recent creations
│   │   ├── template_library_screen.dart# Searchable 30+ template gallery with category filtering
│   │   ├── canvas_screen.dart         # Full interactive sticker canvas with gesture controls
│   │   ├── my_designs_screen.dart     # User creations gallery & favorites filter
│   │   └── packs_screen.dart          # Downloadable collectible packs & studio preferences
│   ├── theme/
│   │   └── app_theme.dart             # Material 3 design system with Electric Blue theme tokens
│   └── widgets/
│       └── studio_widgets.dart        # Custom geometric painters (Star, Hex, Shield, Diamond, Heart)
├── test/
│   ├── unit/
│   │   ├── studio_models_test.dart    # Tests for models, serialization, copyWith
│   │   ├── studio_provider_test.dart  # Tests for canvas operations, undo/redo, templates, packs
│   │   └── theme_provider_test.dart   # Tests for light/dark theme toggles
│   ├── widget/
│   │   └── studio_screens_test.dart   # Widget tests for TemplateLibraryScreen & PacksScreen
│   └── widget_test.dart               # Smoke test for FantasyStudioApp & navigation bar
├── web/
│   ├── index.html                     # Custom branded HTML loader, SEO tags & OpenGraph metadata
│   ├── manifest.json                  # PWA manifest with Nikhil's Fantasy Studio branding
│   └── favicon.png                    # Brand favicon icon
├── pubspec.yaml                       # Clean dependencies and asset declarations
├── run_app.bat                        # One-click Windows launch script
└── run_app.ps1                        # PowerShell launch script with build cache isolation
```

---

## 🛠️ Getting Started & Launch Commands

### Prerequisites
- Flutter SDK (version 3.13.0 or higher)
- Google Chrome (for web run) or Windows Desktop build tools

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Verify Code Quality & Analysis
```bash
flutter analyze
```

### 3. Run Test Suite
```bash
flutter test
```

### 4. Launch Application
To run in Google Chrome:
```bash
flutter run -d chrome
```
Or use the automated Windows runner:
```bash
run_app.bat
```
Or via PowerShell:
```powershell
.\run_app.ps1
```

---

## 🧪 Testing Verification

The project includes unit and widget tests covering all critical paths:

| Test File | Target | Coverage |
| :--- | :--- | :--- |
| `test/unit/studio_models_test.dart` | Models | `StickerTemplate`, `CanvasStickerItem`, `CreatedDesign`, `StickerPack` serialization & `copyWith` |
| `test/unit/studio_provider_test.dart` | State Management | Canvas additions, positioning, scaling, rotation, undo/redo, template filters, pack downloads |
| `test/unit/theme_provider_test.dart` | Theme System | Dark/Light mode toggles and default settings |
| `test/widget/studio_screens_test.dart` | UI Screens | `TemplateLibraryScreen` search/categories & `PacksScreen` rendering |
| `test/widget_test.dart` | App Shell | `FantasyStudioApp` smoke test & `NavigationBar` 5-tab destinations |

---

## 🧹 Audit & Transformation Summary

### Removed Obsolete & Personal Content
- ❌ **17 personal photos** from original student project removed (`srekar.png`, `sriram.png`, `harshith.png`, `joshua.png`, `akhila.png`, `akhiila.png`, `pic1.png`–`pic11.png`).
- ❌ **Old personal naming references** removed throughout codebase (`Srekar Fan Association`, student IDs, personal charity drives).
- ❌ **Obsolete fan page screens** removed (`events_screen.dart`, `fans_screen.dart`, `gallery_screen.dart`, `leadership_screen.dart`, `membership_screen.dart`, `profile_screen.dart`, `updates_screen.dart`, `admin_dashboard.dart`, `experiments_hub_screen.dart`, `api_feed_screen.dart`).
- ❌ **Monolithic duplicate `main.dart`** in root deleted.

### New Assets & Original Content
- ✨ **Custom App Logo**: Generated geometric glowing stylus hexagon badge (`assets/images/logo.png`).
- ✨ **Hero Illustration**: High-resolution digital art studio banner (`assets/illustrations/hero_fantasy.png`).
- ✨ **Original Die-Cut Stickers**: Holographic Crystal Dragon (`sticker_dragon.png`) & Celestial Phoenix (`sticker_phoenix.png`).
- ✨ **Bundled Typography**: Full local suite of Google Fonts **Outfit** TTF files.
- ✨ **Vector Die-Cut Shapes**: Custom Flutter painters for Star, Hexagon, Shield, Diamond, Heart, and Circle stickers.
- ✨ **Branded Web Shell**: Updated `web/index.html` with animated loading screen and `web/manifest.json`.

---

## 📄 License
Created for Nikhil's Fantasy Studio. All rights reserved.
