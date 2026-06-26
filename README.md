# 🌿 get_flora

A cross-platform Flutter app for identifying and retrieving information about plants. Snap or upload a photo of a plant and get back details pulled from a plant-data API.

## Features

- 📷 Capture a plant photo with the device camera, or pick one from your gallery
- 🔍 Look up plant information via a REST API
- 📱 Built with Flutter — runs on Android, iOS, Web, Windows, macOS, and Linux from a single codebase
- 🗂️ Local image handling and caching via `path_provider`

## Tech Stack

- **Framework:** [Flutter](https://flutter.dev) / Dart
- **State management:** [provider](https://pub.dev/packages/provider)
- **Networking:** [http](https://pub.dev/packages/http)
- **Camera & media:** [camera](https://pub.dev/packages/camera), [image_picker](https://pub.dev/packages/image_picker)
- **Filesystem:** [path_provider](https://pub.dev/packages/path_provider), [path](https://pub.dev/packages/path)

## API

This app retrieves plant data from a plant-information API, documented here:

👉 [API Documentation (Postman)](https://documenter.getpostman.com/view/24599534/2s93z5A4v2)

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart SDK `^3.9.4`)
- A connected device, simulator/emulator, or a configured desktop/web target
- Camera permissions enabled on your device/emulator if you want to test photo capture

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/charlvdmerwe/get_flora.git
   cd get_flora
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Run the app
   ```bash
   flutter run
   ```

   To target a specific platform:
   ```bash
   flutter run -d chrome    # Web
   flutter run -d windows   # Windows
   flutter run -d macos     # macOS
   flutter run -d linux     # Linux
   ```

### Running Tests

```bash
flutter test
```

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/charlvdmerwe/get_flora/issues) or open a pull request.
