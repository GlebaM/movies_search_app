# Movies Search App

A Flutter application that lets you discover movies through the public OMDb API. Search by title, browse results in a clean list, and dive into detailed information with rich metadata and ratings.

## Features

- 🔍 Debounced movie search with graceful empty/error states
- 📄 Detail view with plot, cast, crew, ratings, and box-office metadata
- 🧱 Layered architecture (data/domain/presentation) powered by Cubit/BLoC
- 🔐 Configurable OMDb API key via environment file
- ✅ Unit and widget tests covering repositories, cubits, and key UI flows

## Tech Stack

- Flutter 3.24+
- `flutter_bloc` + `equatable`
- `dio` for networking
- `json_serializable` for model generation
- `mocktail` & `flutter_test` for testing

## Getting Started

### 1. Configure environment variables

Create a `.env` file in the project root based on the provided example:

```
cp env.example .env
```

Update `.env` with your OMDb API key:

```
OMDB_API_KEY=your_api_key_here
```

> You can obtain a free key at [omdbapi.com/apikey.aspx](https://www.omdbapi.com/apikey.aspx).

### 2. Install dependencies

```
flutter pub get
```

Generated model files are already checked in. If you modify any `@JsonSerializable` model, regenerate code with:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Run the app

```
flutter run
```

### 4. Run tests

```
flutter test
```

## Project Structure

```
lib/
  app/                # Root widgets and theming
  core/               # Cross-cutting utilities (errors, network)
  features/
    movies/
      data/           # API client, models, repositories
      domain/         # Repository contracts
      presentation/   # Cubits, views, widgets
```

## Notes

- Networking errors are surfaced to the UI with retry actions.
- The app uses a debounced search to avoid unnecessary API calls.
- Logging is enabled in debug builds through a custom Dio interceptor.
- Debug banner is disabled to mirror production visuals for recruitment purposes.

Enjoy exploring movies! 🎬
