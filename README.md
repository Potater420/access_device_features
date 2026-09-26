# Access Device Features — Flutter Device Features App

A Flutter application that progressively integrates native device capabilities: device info, media access, Google Maps/GPS, biometric authentication, and audio recording/playback.

## Features by Phase

| Phase | Feature | Package(s) Used |
|---|---|---|
| 1 | Device Info — displays device model & OS version | `device_info_plus` |
| 2 | Image Picker Gallery — pick multiple images into a `ListView` | `image_picker` |
| 3 | Google Maps — full-screen map with a marker on Cairo Governorate, Egypt | `google_maps_flutter` |
| 4 (Bonus) | Fingerprint Authentication — biometric gate before viewing the Profile page | `local_auth` |
| 5 (Bonus) | Voice Recorder — record and play back audio | `record`, `audioplayers` |

## Project Structure

```
lib/
├── main.dart
└── screens/
    ├── home_screen.dart          # Entry point with navigation to all feature screens
    ├── device_info_screen.dart   # Phase 1
    ├── image_picker_screen.dart  # Phase 2
    ├── google_map_screen.dart    # Phase 3
    ├── profile_screen.dart       # Phase 4 (bonus)
    └── record_screen.dart        # Phase 5 (bonus)
screen_shots/                     # Screenshots demonstrating each phase
```

## Permissions Used

### Android (`android/app/src/main/AndroidManifest.xml`)

| Permission | Used For |
|---|---|
| `INTERNET` | Loading Google Maps tiles |
| `USE_BIOMETRIC` | Fingerprint authentication before accessing the Profile screen |
| `RECORD_AUDIO` | Recording voice notes on the Recorder screen |

> Note: `image_picker` does not require an explicit gallery-access permission on modern Android versions — it uses the system Photo Picker, which does not need runtime permission grants. Location permissions were not requested since the map only displays a static marker and never reads the device's current location.

### iOS (`ios/Runner/Info.plist`)

| Key | Used For |
|---|---|
| `NSPhotoLibraryUsageDescription` | Gallery access for `image_picker` |
| `NSMicrophoneUsageDescription` | Audio recording via `record` |
| `NSFaceIDUsageDescription` | Biometric authentication (Face ID) via `local_auth` |

## Setup

1. **Flutter SDK**: Requires Dart SDK `^3.13.0` (see `pubspec.yaml`).
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Google Maps API Key**:
   - Obtain a key from the [Google Cloud Console](https://console.cloud.google.com/) with the **Maps SDK for Android** and **Maps SDK for iOS** enabled.
   - Add your key to `android/app/src/main/AndroidManifest.xml`:
     ```xml
     <meta-data
         android:name="com.google.android.geo.API_KEY"
         android:value="YOUR_API_KEY_HERE" />
     ```
   - Add your key to `ios/Runner/AppDelegate.swift` following the [google_maps_flutter iOS setup guide](https://pub.dev/packages/google_maps_flutter#ios).
   - Restrict the key in Google Cloud Console to your app's package name / bundle ID and SHA-1 fingerprint (Android) or bundle ID (iOS).
4. **Run the app**:
   ```bash
   flutter run
   ```

## Screenshots

All screenshots are located in [`screen_shots/`](./screen_shots):

- `device info page.jpg` — Device model & OS version (Phase 1)
- `gallery page.jpg` — Picked images displayed in the ListView (Phase 2)
- `google maps page.jpg` — Google Map with red marker on Cairo (Phase 3)
- `finger print authentication prompt.jpg` / `profile page.jpg` — Biometric prompt and Profile page (Phase 4, bonus)
- `audio screen.jpg` — Record Audio / Play Audio buttons (Phase 5, bonus)

## Notes

- Each screen lives in its own file under `lib/screens/` for clarity and separation of concerns.
- Biometric authentication uses `biometricOnly: true`, so only fingerprint/Face ID is accepted (no device PIN/passcode fallback).
- Code was formatted with `dart format .` prior to submission.