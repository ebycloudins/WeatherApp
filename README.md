# Weather App

A Flutter weather application that allows users to search weather information by city name, view current weather conditions, access recent searches, and view cached weather data when offline.

## Features

* Search weather by city name
* Current weather details:
  * Temperature
  * Weather Condition
  * Humidity
  * Wind Speed
* Offline cache support
* Recent searches
* Pull-to-refresh
* Shimmer loading
* Dark mode support

## Setup Instructions

### Prerequisites

* Flutter SDK
* Android Studio or VS Code
* WeatherAPI API Key

### Run the Project

```bash
flutter pub get
flutter run
```

### Build APK

```bash
flutter build apk --release
```

## Architecture

The application follows a simplified Clean Architecture with Repository Pattern.

### Layers

**Presentation Layer**

* UI Screens and Widgets
* Provider for state management
* Handles user interactions and state updates

**Domain Layer**

* Use Cases
* Business logic
* Repository contracts

**Data Layer**

* Remote Data Source (WeatherAPI)
* Local Data Source (Hive)
* Repository implementation

### Data Flow

UI → Provider → Use Case → Repository → Data Source

The repository decides whether to return fresh API data or cached data when offline.

## State Management

* Provider + ChangeNotifier

## Local Storage

* Hive
* Cached weather data
* Recent searches
* Theme preference

## Demo

Screen recording of the app:

[Watch Demo](assets/demo/screen_record.mp4)

[Screenshots](assets/demo/screenshots)

