# Recipe Finder App

A Flutter application that allows users to search and view recipes using the TheMealDB API.

## Features
- Search recipes by keyword (e.g., "chicken").
- Display a list of recipes with thumbnails, names, and brief details.
- Show a detailed view of a recipe with ingredients, instructions, and image.
- Handle loading states, errors, and empty results.

## Project Structure
- **lib/data**: Data sources and repositories for API calls.
- **lib/domain**: Entities (models) and use cases (business logic).
- **lib/presentation**: Providers, screens, and widgets for UI and state management.

## State Management
The app uses Riverpod for state management with the following key components:

### Providers
- **networkServiceProvider**: Provides HTTP client for API calls
- **recipeRemoteDataSourceProvider**: Handles API communication
- **recipeRepositoryProvider**: Implements repository pattern
- **searchRecipesUseCaseProvider**: Encapsulates business logic
- **searchNotifierProvider**: Manages search state and UI updates

### State Flow
1. User types in search bar and submits
2. SearchNotifier receives the query and calls SearchRecipesUseCase
3. Use case calls repository, which calls remote data source
4. Data flows back through the layers
5. UI rebuilds based on new state (loading, success, or error)

### Error Handling
- Network errors are caught and wrapped in Failure objects
- UI displays appropriate error messages with retry options
- Loading states are managed centrally


## How to Run
1. Navigate to the project directory:
   ```bash
   cd recipe_finder
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

