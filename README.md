# GATE ECE Master v2.0

> Professional GATE Electronics & Communication Engineering Preparation App

**Built by Kamal** | 80+ Verified Questions | AI Study Assistant | Step-by-Step Solutions

---

## Features

### Core Learning
- **9 Subjects** covering the complete GATE ECE syllabus
- **80+ Verified MCQ Questions** with detailed step-by-step solutions
- **Module-based Learning** - Theory + Problems + Quiz per chapter
- **Duolingo-style Streaks** with streak freeze protection

### Study Tools
- **AI Study Assistant** - Ask doubts, get formula lookups, concept explanations
- **FAQ Topics** - Most frequently asked topics per subject for focused revision
- **Interactive Circuit Labs** - RLC, Op-Amp, Logic Gate, BJT simulators
- **TCS iON Virtual Calculator** - Practice with the exact exam calculator
- **Formula Sheet** - All important formulas with LaTeX rendering
- **Flashcards** - Quick revision cards for each subject
- **GATE PYQ Papers** - Previous year questions (2018-2024)

### Progress Tracking
- **XP System** - Earn points for every activity
- **Daily Goals** - Set and track daily learning targets
- **Subject Progress** - Visual progress bars for each topic
- **Mock Tests** - Full 3-hour GATE exam simulator

### Premium Experience
- **3 Themes** - Dark Mode, Light Mode, Study Mode (low blue light)
- **Offline** - Works 100% without internet
- **No Ads** - Clean, distraction-free learning
- **Material Design 3** - Modern, professional UI

## Tech Stack
- Flutter 3.x (Dart)
- Provider for state management
- SharedPreferences for local persistence
- Google Fonts (Inter)
- Material Design 3

## Build

### GitHub Actions (Automatic)
Push to `main` branch triggers automatic APK build.

### Codemagic
Connected via `codemagic.yaml` - builds both APK and AAB (for Play Store).

### Local Build
```bash
flutter pub get
flutter build apk --release
flutter build appbundle --release  # For Play Store
```

## Play Store Publishing

### Step 1: Create Google Play Developer Account
1. Go to https://play.google.com/console
2. Pay one-time $25 registration fee
3. Complete identity verification

### Step 2: Create App Listing
1. Click "Create app" in Play Console
2. App name: "GATE ECE Master"
3. Category: Education
4. Fill in description, screenshots, and feature graphic

### Step 3: Upload AAB
1. Go to Production > Create new release
2. Upload the `.aab` file from Codemagic artifacts
3. Add release notes

### Step 4: Content Rating
1. Fill out the content rating questionnaire
2. Category: Education (no violence, no data collection)

### Step 5: Pricing
1. Set as Free
2. Select countries (India + worldwide)

### Step 6: Review & Publish
1. Google reviews in 1-7 days
2. App goes live on Play Store!

## License
Copyright 2024-2026 Kamal. All rights reserved.