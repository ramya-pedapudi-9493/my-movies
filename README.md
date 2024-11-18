# MyMovies App

## Overview
MyMovies App is a cross-platform Flutter application that allows users to browse, search, and save movies using a movie API. The app features API integration, state management, offline support, and responsive UI design. It is designed to provide a seamless and engaging user experience for movie enthusiasts.

---

## Features
1. **Home Screen**:
   - Fetch and display a list of movies from the provided movie API.
   - Each movie shows the title and poster image.
   - A search bar allows users to search for movies by title.

2. **Movie Details Screen**:
   - View detailed information about the selected movie, including:
     - Title
     - Poster Image
     - IMDb ID
   - Option to mark/unmark a movie as a favourite.

3. **Favourites Screen**:
   - Displays a list of movies marked as favourites.
   - Favourites are cached locally for offline access.

4. **Search Functionality**:
   - Real-time search updates as users enter movie titles.

5. **State Management**:
   - Uses `Provider` for managing app state, including movie data, search results, and favourites.


6. **Splash Screen**:
   - Animated splash screen for a smooth app startup experience.

---

## Dependencies
This project uses the following dependencies:
- [Flutter SDK](https://flutter.dev)
- [`carousel_slider`](https://pub.dev/packages/carousel_slider): ^5.0.0
- [`animated_text_kit`](https://pub.dev/packages/animated_text_kit): ^4.2.2
- [`provider`](https://pub.dev/packages/provider): ^6.1.2
- [`http`](https://pub.dev/packages/http): ^1.2.2
- [`cupertino_icons`](https://pub.dev/packages/cupertino_icons): ^1.0.8

---

## Installation and Setup Instructions

### Prerequisites
- Install Flutter SDK (version 3.24.5 or later).
- Ensure you have a code editor like Visual Studio Code or Android Studio installed.
- A device/emulator to run the app.

### Steps
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ramya-pedapudi-9493/my-movies.git 
   cd assignment
Install Dependencies: Run the following command to install the required dependencies:

bash
Copy code
flutter pub get
Run the Application: Use the command below to start the app:

bash
Copy code
flutter run
API Setup:

Replace the API_ENDPOINT in your code with the provided movie API URL.
Test Credentials
No authentication is required for this project. Simply run the app to fetch and interact with movie data.