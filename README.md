#  MovieHive - Premium Movie Database App

MovieHive is a sleek, high-performance movie exploration app built with **Flutter**. It leverages the **TMDB API** to provide real-time movie data, trending content, and detailed insights with a cinematic user experience.

## Key Features

* **Real-time Data:** Fetches trending, popular, and top-rated movies via TMDB.
* **Deep Details:** Comprehensive movie insights including tagline, budget, revenue, and production companies.
* **Dynamic UI:** Uses `Sliver` widgets for smooth scrolling and complex header animations.
* **Smart Loading:** Implements professional **Shimmer effects** to prevent layout shifts.
* **Cast & Recommendations:** Explore movie cast details and get similar movie suggestions.

## Tech Stack & Architecture

* **Framework:** [Flutter](https://flutter.dev)
* **State Management:** [GetX](https://pub.dev/packages/getx) (Reactive approach)
* **Architecture:** Clean Architecture (Layered: Data, Domain, Presentation)
* **API:** [The Movie Database (TMDB)](https://www.themoviedb.org/documentation/api)
* **Responsive UI:** `flutter_screenutil` for pixel-perfect design on all devices.
* **Networking:** `Dio` with interceptors for robust API calls.

##  Project Structure

lib/
├── core/                          
│   ├── theme/
│   │   └── appColors.dart
│   ├── routes/
│   │   └── appRoutes.dart
│   │   └── appPages.dart
│   ├── errors/
│   │   └── failure.dart          # Error handling class
│   ├── network/
│   │   ├── api_constants.dart    # URL aur Keys yahan rahengi
│   │   ├── dio_client.dart       # Dio Setup (Interceptor wala)
│   │   └── api_interceptors.dart # Token inject karne k liye
│   ├── services/
│   │   └── storage_service.dart  # Hive Setup
│   └── utils/
│       └── ui_helpers.dart       # Snackbar helpers
│
├── features/                     # App k main features
│   └── movies/
│       ├── data/                 # Data Layer (Dirty Work)
│       │   ├── datasources/      # API calls (Remote) & Hive calls (Local)
│       │   ├── models/           # JSON/Hive Models (e.g. MovieModel)
│       │   └── repositories/     # Repo Implementation (Either logic yahan hogi)
│       │
│       ├── domain/               # Domain Layer (Pure Logic - No Flutter code)
│       │   ├── entities/         # Simple Dart Class (e.g. Movie)
│       │   └── repositories/     # Abstract Class (Contract/Interface)
│       │
│       └── presentation/         # UI Layer (Visible Work)
│           ├── controllers/      # GetX Controllers
│           ├── pages/            # Screens (Home, Detail, Search)
│           └── widgets/          # Small parts (MovieCard, RatingBadge)
│
└── main.dart                     # Entry Point
