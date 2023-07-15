# Flutter Map App - DHIS2

Flutter Map App is a sample Flutter application that allows users to place markers on an interactive map, add notes to the markers, and persist them for future use. It provides a simple way to explore and interact with a map while managing location-based information.

## Features

- Interactive map with panning and zooming capabilities.
- Marker placement by clicking on the map.
- Adding notes to markers by tapping on them.
- Marker and note persistence even after app restarts.
- Viewing and deleting markers.

## Installation

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: Should be included with Flutter SDK.
- IDE: Android Studio or Visual Studio Code (recommended).

### Clone the Repository

```bash
git clone https://github.com/wile44/interactive-map-app-dhis2
cd interactive-map-app-dhis2
````

### Install Dependencies

```bash
flutter pub get
```

### Run the App

Connect a physical device or start an emulator, and run the following command:

```bash
flutter run
```

This will compile the Flutter code and launch the app on your device or emulator.

## Dependencies

The Flutter Map App relies on the following dependencies:

- `google_maps_flutter: ^2.0.9`: Provides the map display and marker functionality.
- `shared_preferences: ^2.0.8`: Handles local storage for marker and note persistence.
- `geolocator: ^7.0.3`: Provide current user location to improve experience.

These dependencies will be automatically fetched when running `flutter pub get`.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please submit an issue or pull request.

## License

[MIT License](LICENSE)

                                                                           
