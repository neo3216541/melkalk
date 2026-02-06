# Clean Architecture Implementation

This Flutter application follows Clean Architecture principles with the following structure:

## Architecture Overview

```
lib/
├── core/
│   ├── constants/         # App-wide constants
│   ├── di/               # Dependency injection (GetIt)
│   ├── router/           # Navigation (GoRouter)
│   └── theme/            # App themes
│
└── features/
    ├── mel_calculator/
    │   ├── data/
    │   │   ├── datasources/    # Data sources (not used in this feature)
    │   │   ├── models/         # Data models
    │   │   └── repositories/   # Repository implementations
    │   ├── domain/
    │   │   ├── entities/       # Business entities
    │   │   ├── repositories/   # Repository interfaces
    │   │   └── usecases/       # Business logic
    │   └── presentation/
    │       ├── bloc/           # BLoC state management
    │       ├── pages/          # UI screens
    │       └── widgets/        # Reusable widgets
    │
    └── settings/
        ├── data/
        │   ├── datasources/    # Local data sources
        │   ├── models/         # Data models
        │   └── repositories/   # Repository implementations
        ├── domain/
        │   ├── entities/       # Business entities
        │   ├── repositories/   # Repository interfaces
        │   └── usecases/       # Business logic
        └── presentation/
            ├── bloc/           # BLoC state management
            ├── pages/          # UI screens
            └── widgets/        # Reusable widgets
```

## Key Technologies

- **State Management**: Flutter BLoC (flutter_bloc)
- **Dependency Injection**: GetIt
- **Navigation**: GoRouter
- **Local Storage**: SharedPreferences
- **Architecture**: Clean Architecture (simplified)

## Layers

### 1. Domain Layer
Pure Dart business logic with no Flutter dependencies:
- **Entities**: Core business objects (e.g., `AppSettings`, `MelCategory`)
- **Repositories**: Abstract interfaces defining data operations
- **Use Cases**: Single-responsibility business operations

### 2. Data Layer
Implements domain repositories and handles data:
- **Data Sources**: Interfaces with external data (SharedPreferences)
- **Models**: Data transfer objects that extend entities
- **Repositories**: Concrete implementations of domain repositories

### 3. Presentation Layer
UI and state management:
- **BLoC**: State management following BLoC pattern
- **Pages**: Full-screen UI components
- **Widgets**: Reusable UI components

## Dependency Flow

```
Presentation → Domain ← Data
```

- Presentation layer depends on Domain
- Data layer depends on Domain
- Domain has no dependencies (pure business logic)

## Features

### MEL Calculator
Calculates UTC dates for ICAO MEL limitation categories (A, B, C, D).

### Settings
Manages app configuration:
- Theme mode (light/dark/system)
- Category delay values
- Time format (12h/24h)

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

## Testing

The architecture facilitates testing by separating concerns:
- Unit test use cases independently
- Mock repositories for presentation layer tests
- Test data sources in isolation
