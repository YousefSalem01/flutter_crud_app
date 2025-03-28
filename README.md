Flutter CRUD Demo App
A demonstration project that implements a CRUD application with clean architecture, following best practices for Flutter development.
Table of Contents
Overview
Features
Project Structure
Architecture
Installation
Dependencies
API Reference
Data Flow
Error Handling Strategy
Overview
This Flutter application demonstrates how to build a maintainable, scalable app using clean architecture principles. It connects to the JSONPlaceholder API to perform CRUD operations (Create, Read, Update, Delete) on posts.
The project serves as a practical example of implementing modern Flutter development practices, including state management with Cubit, dependency injection, routing, error handling, and more.
Features
View a list of posts
View post details
Create new posts
Update existing posts
Delete posts
Error handling
Network connectivity checks
Responsive UI design
Light and dark theme support
Project Structure
The application follows a clean architecture approach with the following layers:

lib/
├── core/ # Core functionality used across the app
│ ├── api/ # API handling
│ ├── error/ # Error handling
│ ├── network/ # Network connectivity
│ ├── utils/ # Utilities and constants
│ ├── widgets/ # Shared widgets
│ └── di/ # Dependency injection
├── data/ # Data layer
│ ├── datasources/ # Remote and local data sources
│ ├── models/ # Data models
│ └── repositories/# Repository implementations
├── domain/ # Domain layer
│ ├── entities/ # Business entities
│ ├── repositories/# Repository interfaces
│ └── usecases/ # Business use cases
├── presentation/ # Presentation layer
│ ├── cubit/ # State management
│ ├── pages/ # Screen pages
│ └── widgets/ # UI components
├── config/ # App configuration
│ ├── routes/ # Navigation routes
│ └── themes/ # App themes
└── main.dart # App entry point

Architecture
Core Layer
Contains essential functionality used throughout the app:
API Handling: Abstractions and implementations for API communication using Dio
Error Handling: Custom exceptions and failure classes
Network: Internet connectivity checking
Utils: Application constants and utilities
Widgets: Shared UI components
Dependency Injection: Service locator pattern implementation using GetIt
Data Layer
Manages data retrieval and storage:
Data Sources: Implementations for fetching data from remote API
Models: Data classes with serialization/deserialization logic
Repository Implementations: Concrete implementations of repository interfaces
Domain Layer
Contains the business logic:
Entities: Core business models
Repository Interfaces: Contracts for data operations
Use Cases: Single-responsibility business logic units
Presentation Layer
Manages the UI and state:
Cubit: State management for each feature
Pages: Full screen UI components
Widgets: Reusable UI components
Config Layer
Application-wide settings:
Routes: Navigation configuration using GoRouter
Themes: Light and dark theme definitions
Installation
Prerequisites
Flutter SDK (2.0.0 or higher)
Dart SDK (2.12.0 or higher)
An IDE (VS Code, Android Studio, etc.)
Clone the repository
flutter pub get
flutter run

Dependencies
State Management
flutter_bloc: ^8.1.3 - State management
equatable: ^2.0.5 - Value equality
Networking
dio: ^5.4.0 - HTTP client
internet_connection_checker: ^1.0.0+1 - Connectivity checking
Navigation
go_router: ^13.1.0 - Routing
UI
flutter_screenutil: ^5.9.0 - Responsive UI
cached_network_image: ^3.3.1 - Image caching
Utilities
dartz: ^0.10.1 - Functional programming
get_it: ^7.6.4 - Dependency injection
API Reference
This app uses the JSONPlaceholder API, a free fake API for testing and prototyping.
Endpoints Used
GET /posts - Retrieve all posts
GET /posts/{id} - Retrieve a specific post
POST /posts - Create a new post
PUT /posts/{id} - Update a post
DELETE /posts/{id} - Delete a post
Data Flow
User interacts with the UI
UI events are passed to the Cubit
Cubit executes the appropriate use case
Use case calls repository methods
Repository retrieves data from data sources (remote or local)
Data flows back through the layers
Cubit updates state based on results
UI reacts to state changes
Error Handling Strategy
The application uses the Either type from dartz to handle errors:
Right side contains successful results
Left side contains failure information
This approach ensures proper error propagation through the layers and appropriate UI feedback.
File Structure Details
Core Layer Files
API
api_consumer.dart - Abstract interface for API operations
dio_consumer.dart - Implementation using Dio HTTP client
app_interceptors.dart - Request/response interceptors for logging and headers
status_code.dart - HTTP status code constants
Error
exceptions.dart - Custom exception classes
failures.dart - Domain-level failure representations
error_handler.dart - Error handling utilities
Network
network_info.dart - Network connectivity checking abstraction and implementation
Utils
constants.dart - Application-wide constants including API endpoints
Widgets
loading_widget.dart - Reusable loading indicator
Dependency Injection
injection_container.dart - Service locator configuration using GetIt
Data Layer Files
Data Sources
post_remote_data_source.dart - API-related data operations for posts
Models
post_model.dart - Data model with JSON serialization/deserialization
Repositories
post_repository_impl.dart - Implementation of repository interface
Domain Layer Files
Entities
post.dart - Post entity representing core business object
Repositories
post_repository.dart - Repository interface defining data operations
Use Cases
get_all_posts.dart - Retrieve all posts
get_post_by_id.dart - Retrieve single post
add_post.dart - Create new post
update_post.dart - Update existing post
delete_post.dart - Remove post
Presentation Layer Files
Cubit
posts_cubit.dart - State management logic
posts_state.dart - State definitions for posts feature
Pages
posts_page.dart - Main screen displaying post list
post_detail_page.dart - Screen showing post details
post_add_update_page.dart - Screen for adding/editing posts
Widgets
post_list_widget.dart - Reusable post list component
post_form_widget.dart - Form for post creation/editing
Config Layer Files
Routes
app_routes.dart - Navigation routes using GoRouter
Themes
app_theme.dart - App theme definitions (light and dark)
Main File
main.dart - Application entry point and initialization
