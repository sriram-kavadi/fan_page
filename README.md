# ✦ Rathnaveri Kavitha Official Fan Page

> **Unity • Culture • Leadership • Social Service**  
> An original, high-performance community application and digital fan hub dedicated to **Rathnaveri Kavitha**.

---

## 🌟 Overview & Identity

**Rathnaveri Kavitha Official Fan Page** is a dedicated cultural, youth leadership, and community association hub. Engineered with Flutter (Material 3) and a custom **Imperial Crimson & Amber Gold** design system, the application delivers an authentic, feature-packed digital experience connecting thousands of volunteers and supporters across 33+ districts.

The application is completely original in layout, visual identity, and interaction patterns—crafted specifically for community engagement, event mobilization, and digital fan membership.

---

## 🎨 Visual Identity & Design System

- **Brand Name**: Rathnaveri Kavitha Official Fan Page (RK Fans)
- **Primary Color Palette**:
  - `Royal Ruby Crimson` (`#D90429` / `#EF233C`): Bold, passionate, authoritative primary action color.
  - `Imperial Amber Gold` (`#FFB703` / `#FB8500`): Regal crest accents, verified member badges, and highlights.
  - `Auspicious Emerald` (`#2A9D8F`): Active confirmations and social charity indicators.
  - `Midnight Obsidian` (`#0B0F19` / `#161E2E`): Sleek, immersive dark mode backdrop.
  - `Royal Warm Ivory` (`#FAF9F6`): Dignified, readable light mode surface.
- **Typography**: Google Fonts **Outfit** (Weights 400 through 800) bundled locally.
- **Vector Crest**: Custom mathematical `CustomPainter` rendering a glowing gold-rimmed laurel crest with the iconic **RK** monogram.

---

## 🚀 Key Features

### 1. 🏠 Interactive Home Dashboard
- **Spotlight Hero**: Royal emblem crest with radiant glow, live follower stats, and interactive `PulseCheerButton` that increments real-time global cheers.
- **Inspiration of the Day**: Rotating daily wisdom cards reflecting cultural pride and leadership values.
- **Impact Statistics**: Live counters tracking 33 Active Districts, 25,000+ Volunteers, 142+ Events Held, and 58 Mega Blood Drives.
- **Quick Action Grid**: One-tap shortcuts to Digital Fan ID, Community Wall, Events, and Journey Milestones.
- **Digital Pass Callout**: Direct CTA to generate an official verified digital membership card.
- **State Chapter Network**: Live horizontal directory of active district leads and volunteer corps.

### 2. 🪪 Digital Fan ID Card Generator
- **Interactive 3D Metallic Card**: Real-time reactive preview that updates live as the fan fills out their details.
- **Selectable Membership Tiers**:
  - 👑 *Royal Patron VIP* (Crimson-Gold metallic gradient)
  - 🌟 *Gold Youth Leader* (Burnished Gold metallic reflection)
  - 🛡️ *Silver Volunteer* (Polished Platinum-Silver finish)
- **Cryptographic QR Code**: Stylized 2D QR pattern embedded with unique state membership number (`RK-VIP-2026-XXXX`).
- **Download & Verification Pass**: Generates official digital entry credentials valid for priority rally access.

### 3. 💬 Community Fan Wall
- **Live Fan Message Stream**: Authentic messages, greetings, and cheers from grassroots supporters.
- **Category Filter Chips**: Filter by *Inspiration*, *Charity & Social Work*, *Events & Rallies*, and *Cultural Pride*.
- **Instant Search**: Real-time search across fan names, messages, or districts.
- **Interactive Post Creator**: Full modal form enabling any supporter to post messages with custom tags.
- **Interactive Cheer Toggles**: One-tap heart cheering with live count animation.

### 4. 📅 Events, Summits & Rallies
- **Comprehensive Event Schedule**: Listings for Youth Sammelanams, Mega Blood Drives, Bathukamma Festivals, and Educational Aid Drives.
- **Interactive RSVP**: Instant registration toggle with live attendee counters.
- **Gate Pass QR Modal**: Generates digital admission ticket with venue details, time, and member verification.

### 5. 🏛️ Journey & Milestones Timeline
- **Chronological Vertical Timeline**: Rich biographical steps highlighting grassroots heritage roots, formation of the youth wing, crisis relief networks, and the 2026 digital vision.

### 6. 🎙️ Media & Speeches Vault
- **Curated Archives**: Filterable galleries for public addresses, cultural celebrations, and charity distributions.
- **Interactive Audio Preview**: Audio player controls for keynote speeches and folk heritage songs.

### 7. 🗳️ Live Fan Voice Poll
- **Community Democracy**: Real-time voting on community priority initiatives with animated percentage progress bars.

### 8. 🌓 Dual Imperial Theme Engine
- Seamless, contrast-optimized switching between Imperial Dark Mode and Royal Warm Ivory Light Mode.

---

## 📂 Project Architecture

```
rathnaveri_kavitha_fan_page/
├── assets/
│   ├── fonts/                         # Bundled Outfit font files (400 to 800 weights)
│   └── images/                        # Brand iconography and assets
├── lib/
│   ├── main.dart                      # MultiProvider root & 5-destination NavigationBar
│   ├── models/
│   │   └── fan_models.dart            # FanMemberCard, CommunityWish, FanEvent, LifeMilestone, FanPoll
│   ├── providers/
│   │   ├── fan_provider.dart          # Central reactive state: cheers, member card, wishes, events, polls
│   │   └── theme_provider.dart        # Theme switching logic
│   ├── screens/
│   │   ├── home_screen.dart           # Dashboard, stats, quotes, quick actions & chapters
│   │   ├── fan_id_screen.dart         # Interactive digital membership card generator
│   │   ├── community_screen.dart      # Real-time fan wall with category filters & posting modal
│   │   ├── events_screen.dart         # Upcoming events, RSVP passes & ticket modals
│   │   └── journey_screen.dart        # Chronological timeline, media vault & live poll
│   ├── theme/
│   │   └── app_theme.dart             # Imperial Crimson & Amber Gold Material 3 theme tokens
│   └── widgets/
│       └── rk_widgets.dart            # Vector crest painter, metallic ID card widget, pulse cheer button
├── test/
│   ├── unit/
│   │   ├── fan_models_test.dart       # Model validation & serialization unit tests
│   │   ├── fan_provider_test.dart     # State management & reactive logic unit tests
│   │   └── theme_provider_test.dart   # Dark/light theme unit tests
│   └── widget_test.dart               # Full app smoke test & navigation bar verification
├── web/
│   ├── index.html                     # Branded crimson-gold loading screen & SEO metadata
│   ├── manifest.json                  # PWA configuration for mobile web installation
│   └── favicon.png                    # Brand favicon
├── pubspec.yaml                       # Clean dependencies and asset declarations
├── vercel.json                        # Vercel deployment configuration & SPA routing
├── vercel_build.sh                    # Automated cloud build script
├── run_app.bat                        # Windows launch script
└── run_app.ps1                        # PowerShell launch script
```

---

## 🛠️ Getting Started & Launch Commands

### Prerequisites
- Flutter SDK (version 3.13.0 or higher)
- Google Chrome or any modern web browser

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

### 4. Launch Application on Chrome
```bash
flutter run -d chrome
```

Or run via automated Windows scripts:
```cmd
run_app.bat
```
Or via PowerShell:
```powershell
.\run_app.ps1
```

---

## 🚀 Vercel Deployment

This project is pre-configured for automated Vercel deployment:
1. Push code to your repository:
   ```bash
   git push origin main
   ```
2. In [Vercel Dashboard](https://vercel.com/new), import your repository.
3. Build command (`bash vercel_build.sh`) and output directory (`build/web`) are automatically detected via [`vercel.json`](file:///d:/project/fan_page/vercel.json).
4. Click **Deploy** for free global CDN hosting with automatic HTTPS!

---

## 📄 License
Created for Rathnaveri Kavitha Official Fan Association. All rights reserved.
