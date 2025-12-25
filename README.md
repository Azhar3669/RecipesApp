# Recipe App

## Project Overview
Recipe App is a small iOS application that allows users to browse delicious recipes fetched from a public API (TheMealDB).

## Main Features
- Fetch recipes from a public API
- Display a list of recipes with images
- View recipe details including ingredients and instructions
- Splash screen on app launch
- Loading states while fetching data
- Language toggle button (English / Arabic)
- Favorites screen to view and manage favorite recipes
- Mark/unmark recipes as favorite from the detail screen

## Objective
Demonstrate mobile development skills, clean architecture principles, and proper UI state handling in a small-scale iOS application.

## Architecture
The application follows the **MVVM (Model–View–ViewModel)** architecture to ensure clean separation of concerns and maintainable code.

### Model
- **Recipe.swift**  
  Represents a recipe and its details.

### Services
- **RecipeAPIService.swift**  
  Handles all API requests, decodes JSON data, and returns results to the ViewModel.

### ViewModel
- **RecipeViewModel.swift**  
  Handles data fetching, loading states, search functionality, favorites, and error handling.
- **SplashViewModel.swift**  
  Controls the splash screen timing and transition.
- **LanguageManager.swift**  
  Handles dynamic switching between English and Arabic.

### View

- **SplashScreenView.swift**  
  Displays the launch screen with the app logo and language toggle.
- **HomeScreen.swift**  
  Displays a list of recipes, search bar, language toggle, and button to navigate to favorites.
- **RecipeDetailView.swift**  
  Shows recipe details, ingredients, instructions, and favorite toggle.
- **FavoritesView.swift**  
  Displays favorite recipes and allows navigating to the recipe detail.

## Screens

### Splash Screen
Displays the app logo, app name, and language toggle. Automatically navigates to the main screen after a short delay.

### Home Screen
Shows a scrollable list of recipes with images, search bar, language toggle, and favorites button.

### Detail Screen
Displays detailed recipe instructions, ingredients, and favorite toggle.

### Favorites Screen
Shows all favorite recipes and allows removing them from favorites.

## API Used
- **TheMealDB**  
  Endpoint: `https://www.themealdb.com/api/json/v1/1/search.php?s=`  
  Free, public API, no API key required

## How to Run the Project
1. Open the project in **Xcode**
2. Select a simulator or a connected iOS device
3. Press **Run **
4. Make sure you have an active internet connection to fetch recipes from the API

## Author
- **Azhar Ghurab**
