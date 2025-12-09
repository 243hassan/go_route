# go_route

A Flutter project to create phrases with hashtags, highlight hashtags in real-time, and display results with proper formatting.

## Features

- **ScreenA (Home):** Welcome screen with "Get Started" button.
- **ScreenB (Results):** Displays submitted phrase and hashtags.
  - Hashtags are highlighted in a different color.
  - Edit button to modify content.
  - Done button navigates back to Home with a congratulations popup.
- **ScreenC (Create Content):** Phrase and Hashtags input screen.
  - Phrase field highlights hashtags as the user types.
  - Hashtags field auto-populates from Phrase but allows manual edits.
- Navigation using `go_router`.

## Getting Started

This project is a starting point for a Flutter application using `go_router` for navigation.

### Prerequisites

- Flutter SDK (latest stable version)
- Dart
- A code editor like VS Code or Android Studio

### Running the App

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
