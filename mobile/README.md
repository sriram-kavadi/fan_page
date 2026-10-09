# Legal Metrology Mobile App 📱

React Native + Expo mobile client for the Department of Legal Metrology Online Verification & Certification System.

## Architecture

```
React Native + Expo Mobile
        ↓
   services/api.js (fetch + JWT)
        ↓
Existing Express API (backend/)
        ↓
     Supabase / In-Memory DB
```

## Project Structure

```
mobile/
├── App.js                          # Root entry point
├── app.json                        # Expo config
├── .env                            # Environment variables (local only)
├── .env.example                    # Template for env vars
│
├── app/
│   ├── navigation/
│   │   ├── RootNavigator.js        # Auth vs App routing logic
│   │   ├── AuthNavigator.js        # Login / Register stack
│   │   ├── OwnerNavigator.js       # OWNER role bottom tabs
│   │   └── OfficerNavigator.js     # LMO / GATC / ADMIN tabs
│   │
│   └── screens/
│       ├── auth/
│       │   ├── LoginScreen.js
│       │   └── RegisterScreen.js
│       ├── owner/
│       │   ├── OwnerDashboardScreen.js
│       │   ├── MyInstrumentsScreen.js
│       │   ├── MyApplicationsScreen.js
│       │   └── MyCertificatesScreen.js
│       ├── lmo/
│       │   └── LMODashboardScreen.js
│       ├── admin/
│       │   └── AdminDashboardScreen.js
│       ├── public/
│       │   └── PublicVerifyScreen.js
│       └── profile/
│           └── ProfileScreen.js
│
├── components/
│   └── common/
│       ├── Button.js               # Multi-variant button
│       ├── Card.js                 # Surface card
│       ├── EmptyState.js           # Empty list placeholder
│       ├── ErrorBanner.js          # Inline error display
│       ├── Input.js                # Form text input
│       ├── LoadingScreen.js        # Full-screen loader
│       ├── SectionHeader.js        # List section heading
│       └── StatusBadge.js          # Colored status pill
│
├── context/
│   └── AuthContext.js              # Global auth state (SecureStore-backed)
│
├── hooks/
│   └── useApi.js                   # Generic data-fetching hook
│
├── services/
│   ├── api.js                      # HTTP client (all API methods)
│   ├── authService.js              # Login/logout + SecureStore token management
│   ├── adminService.js
│   ├── applicationService.js
│   ├── certificateService.js
│   ├── instrumentService.js
│   ├── notificationService.js
│   └── publicService.js
│
└── utils/
    ├── helpers.js                  # Date, currency, text utilities
    └── theme.js                    # Design tokens (colors, spacing, etc.)
```

## Getting Started

### 1. Prerequisites

- Node.js 18+
- Expo CLI: `npm install -g expo-cli`
- Expo Go app on your physical device, OR an Android/iOS emulator

### 2. Environment Setup

```bash
cd mobile
cp .env.example .env
```

Edit `.env` and set your **machine's LAN IP** (not `localhost`):

```bash
# Windows: run `ipconfig` and look for IPv4 Address
EXPO_PUBLIC_API_URL=http://192.168.1.XXX:5000/api
```

> ⚠️ Physical devices cannot reach `localhost` on your dev machine. Always use your LAN IP.

### 3. Start the Backend

```bash
cd ../backend
npm run dev
# Backend starts on http://localhost:5000
```

### 4. Run the Mobile App

```bash
cd ../mobile
npm start          # Opens Expo dev tools
npm run android    # Opens Android emulator directly
npm run ios        # Opens iOS simulator (macOS only)
```

Scan the QR code in the terminal with **Expo Go** on your phone.

---

## User Roles & Demo Credentials

| Role | Email | Password |
|------|-------|----------|
| **ADMIN** | admin@legalmetrology.demo | DemoPassword@2026 |
| **OWNER** | owner@business.demo | DemoPassword@2026 |
| **LMO** | lmo@legalmetrology.demo | DemoPassword@2026 |
| **GATC** | gatc@testcentre.demo | DemoPassword@2026 |

Each role sees a different navigation structure and features:

- **OWNER** — Dashboard, My Instruments, Applications, Certificates, Profile
- **LMO / GATC** — Assigned Verifications, Certificate Verify, Profile  
- **ADMIN** — System Stats, Stakeholder/Officer Management, Audit Logs, Profile

---

## Security

- JWT tokens are stored in **Expo SecureStore** (hardware-backed encryption on device)
- Tokens are **never** stored in AsyncStorage or plain text
- All API calls automatically attach the `Authorization: Bearer <token>` header
- The backend's CORS is already open to `*` for development

---

## API Service Layer

All backend communication goes through `services/api.js`. Never call `fetch` directly in screen components.

```js
// ✅ Correct — use the service layer
import { instrumentService } from '../services/instrumentService';
const data = await instrumentService.list();

// ❌ Wrong — don't do this in screens
const data = await fetch('http://localhost:5000/api/instruments');
```

---

## Environment Variables

All Expo-compatible env vars must be prefixed with `EXPO_PUBLIC_`:

| Variable | Description |
|----------|-------------|
| `EXPO_PUBLIC_API_URL` | Backend API base URL (required) |
| `EXPO_PUBLIC_APP_NAME` | Display name (optional) |
| `EXPO_PUBLIC_APP_ENV` | `development` / `production` (optional) |
