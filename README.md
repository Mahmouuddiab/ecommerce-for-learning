# 🛒 E-Commerce Mobile Application

A **feature-rich, scalable, and modern E-Commerce mobile application** built with **Flutter**, following **Feature-First Clean Architecture** and powered by **Riverpod** for reactive state management.

The application provides a complete shopping experience, from authentication and product discovery to cart management, checkout, orders, addresses, wishlist, and product reviews.

---

## 🌟 Key Features

### 🔐 Authentication & Authorization

* User registration and login
* Forgot password functionality
* OTP verification
* Password reset
* JWT-based authentication
* Secure token storage
* Automatic authentication state handling

### 🏠 Home & Product Discovery

* Modern home dashboard
* Featured products
* Product categories
* Sub-categories
* Product details
* Dynamic product search
* Filtering and product discovery

### 📦 Product Catalog

* Browse products by category
* View detailed product information
* Product images and pricing
* Product availability
* Related products
* Search and filtering functionality

### 🛒 Cart & Checkout

* Add and remove products from cart
* Update product quantities
* Real-time cart calculations
* Automatic total price updates
* Select saved delivery addresses
* Cash and card payment options
* Complete order placement flow

### 📍 Address Management

Complete CRUD functionality for delivery addresses:

* Add new addresses
* View saved addresses
* Update existing addresses
* Delete addresses
* Select an address during checkout

### ❤️ Wishlist

* Add products to wishlist
* Remove products from wishlist
* View favorite products
* Quickly access saved products

### ⭐ Reviews & Ratings

* View product reviews
* Add product reviews
* Submit ratings
* Review products after purchase

### 📋 Orders

* Place orders
* View order history
* Track order information
* View order details
* Support for cash and card orders

### 👤 Profile & Settings

* View user profile
* Manage account information
* Manage saved addresses
* Application settings
* Localization preferences

### 🌍 Multi-Language Support

* Internationalization (i18n)
* Localization using `easy_localization`
* Support for multiple languages
* Easily extendable translation structure

### 📱 Responsive UI

* Responsive layouts across different screen sizes
* Pixel-perfect UI implementation
* Adaptive dimensions using `flutter_screenutil`
* SVG support using `flutter_svg`
* Reusable UI components

---

# 🏗 Architecture

The project follows a **Feature-First Clean Architecture** approach.

The application is organized into three major areas:

* **Core** → Shared application infrastructure
* **Features** → Business/domain-specific modules
* **Shared** → Reusable UI components and widgets

This structure makes the project:

* ✅ Scalable
* ✅ Maintainable
* ✅ Testable
* ✅ Easy to extend
* ✅ Easy for teams to collaborate on
* ✅ Suitable for production applications

---

# 📂 Project Structure

```text
lib/
│
├── core/                              # Global & Shared Infrastructure
│   ├── cache/                         # Secure storage & persistent cache
│   ├── error/                         # Failures & exception handling
│   ├── localization/                  # Localization & translation setup
│   ├── network/                       # Dio client, APIs & interceptors
│   ├── params/                        # Request parameters / DTOs
│   ├── router/                        # Application routing
│   ├── screens/                       # Shared/base screens
│   ├── utils/                         # Constants, colors, themes & helpers
│   └── validator/                     # Form & input validation
│
├── features/                          # Feature-Based Modules
│   │
│   ├── addresses/                     # Address Management
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── auth/                          # Authentication & Verification
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── cart/                          # Cart Management
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── category/                      # Categories & Sub-categories
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── home/                          # Home Dashboard & Feeds
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── order/                         # Checkout & Orders
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── profile/                       # User Profile & Settings
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── reviews/                       # Product Reviews & Ratings
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── wishlist/                      # Wishlist & Favorites
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── shared/                            # Reusable UI Components & Widgets
│
└── main.dart                          # Application Entry Point
```

> **Note:** The `data`, `domain`, and `presentation` layers inside each feature keep responsibilities separated and make each feature easier to maintain and test independently.

---

# 🧱 Clean Architecture Layers

Each major feature follows the principles of Clean Architecture.

### 📊 Data Layer

Responsible for communication with external data sources.

Includes:

* API services
* Remote data sources
* Models
* DTOs
* Repository implementations
* JSON serialization/deserialization

Example:

```text
data/
├── datasources/
├── models/
└── repositories/
```

---

### 🧠 Domain Layer

Contains the application's business logic and remains independent of external frameworks.

Includes:

* Entities
* Repository contracts
* Use cases
* Business rules

Example:

```text
domain/
├── entities/
├── repositories/
└── usecases/
```

---

### 🎨 Presentation Layer

Responsible for the UI and application state.

Includes:

* Screens
* Widgets
* Riverpod providers
* Controllers/notifiers
* UI states

Example:

```text
presentation/
├── providers/
├── screens/
└── widgets/
```

---

# 🛠 Tech Stack

| Category               | Technology                           | Purpose                                          |
| ---------------------- | ------------------------------------ | ------------------------------------------------ |
| Framework              | **Flutter**                          | Cross-platform mobile development                |
| Language               | **Dart**                             | Application development                          |
| Architecture           | **Feature-First Clean Architecture** | Scalable project structure                       |
| State Management       | **Riverpod**                         | Reactive state management & dependency injection |
| Networking             | **Dio**                              | REST API communication & interceptors            |
| Functional Programming | **Dartz**                            | Functional error handling with `Either`          |
| Authentication         | **JWT**                              | Secure authentication & authorization            |
| Token Handling         | **jwt_decoder**                      | Decode and validate JWT tokens                   |
| Secure Storage         | **flutter_secure_storage**           | Secure token and credential storage              |
| Navigation             | **go_router / Navigator**            | Application routing and navigation               |
| Responsive UI          | **flutter_screenutil**               | Screen and size adaptation                       |
| Vector Graphics        | **flutter_svg**                      | SVG rendering                                    |
| Localization           | **easy_localization**                | Internationalization and localization            |
| Equality               | **equatable**                        | Value-based object comparison                    |

---

# 🔄 Application Flow

The application follows a clear separation of responsibilities:

```text
UI / Screen
     │
     ▼
Riverpod Provider
     │
     ▼
Use Case
     │
     ▼
Repository Interface
     │
     ▼
Repository Implementation
     │
     ▼
Remote Data Source
     │
     ▼
Dio / REST API
     │
     ▼
Backend Server
```

This approach prevents the UI from being tightly coupled to API implementation details and makes individual components easier to replace or test.

---

# 🔐 Authentication Flow

```text
Register
   │
   ▼
Send Registration Data
   │
   ▼
OTP Verification
   │
   ▼
Account Activated
   │
   ▼
Login
   │
   ▼
Receive JWT
   │
   ▼
Secure Token Storage
   │
   ▼
Authenticated Application
```

The authentication system uses JWT tokens with secure local storage for maintaining authenticated sessions.

---

# 🛒 Shopping Flow

```text
Home
  │
  ▼
Categories / Search
  │
  ▼
Product Details
  │
  ├──── Add to Wishlist
  │
  └──── Add to Cart
             │
             ▼
           Cart
             │
             ▼
       Select Address
             │
             ▼
      Select Payment
             │
             ▼
        Place Order
             │
             ▼
       Order History
```

---

# ⚡ State Management

The project uses **Riverpod** to manage application state and dependencies.

Riverpod is used to handle areas such as:

* Authentication state
* Product state
* Categories
* Cart
* Wishlist
* Addresses
* Orders
* Reviews
* User profile
* Loading and error states

This provides predictable state management while keeping business logic separated from UI components.

---

# 🌐 Networking

API communication is handled using **Dio**.

The networking layer provides:

* REST API requests
* Request configuration
* Authorization headers
* JWT token handling
* Interceptors
* Error handling
* Request/response processing
* Centralized API configuration

Example architecture:

```text
Dio Client
    │
    ├── Base URL
    ├── Headers
    ├── Authorization
    ├── Interceptors
    └── Error Handling
```

---

# ❌ Error Handling

The application uses functional error handling with **Dartz** and the `Either` type.

A typical flow is:

```text
API Request
     │
     ├── Success ──► Right(Data)
     │
     └── Failure ──► Left(Failure)
```

This allows errors to be handled explicitly without relying entirely on exceptions throughout the application.

---

# 💾 Local Storage

Sensitive authentication data is stored securely using:

* `flutter_secure_storage`
* JWT token management
* `jwt_decoder`

This helps protect authentication credentials while allowing the application to maintain user sessions.

---

# 🌍 Localization

The application uses `easy_localization` to support multiple languages.

The localization structure is designed to make adding new languages straightforward:

```text
assets/
└── translations/
    ├── en.json
    └── ar.json
```

Example:

```json
{
  "login": "Login",
  "email": "Email",
  "password": "Password"
}
```

---

# 📱 Responsive Design

The UI uses `flutter_screenutil` to provide responsive sizing across different devices.

Example configuration:

```dart
ScreenUtilInit(
  designSize: const Size(430, 932),
  child: MaterialApp(
    // ...
  ),
);
```

This allows dimensions, spacing, fonts, and other UI elements to adapt to different screen sizes.

---

# 🎯 Development Principles

The project follows several software engineering principles:

* **Clean Architecture**
* **SOLID principles**
* **Separation of Concerns**
* **Single Responsibility Principle**
* **Dependency Inversion**
* **DRY — Don't Repeat Yourself**
* **Reusable Components**
* **Feature-Based Organization**
* **Maintainable & scalable code**
* **Consistent error handling**
* **Responsive UI design**

---

# 🚀 Main Modules

| Module       | Responsibilities                         |
| ------------ | ---------------------------------------- |
| 🔐 Auth      | Registration, login, OTP, password reset |
| 🏠 Home      | Dashboard, products and feeds            |
| 📦 Category  | Categories and sub-categories            |
| 🛒 Cart      | Cart items and price calculations        |
| 📍 Addresses | Delivery address CRUD                    |
| ❤️ Wishlist  | Favorite products                        |
| ⭐ Reviews    | Product ratings and reviews              |
| 📋 Orders    | Checkout and order history               |
| 👤 Profile   | User information and settings            |

---

# 💡 Project Highlights

* 🏗 Feature-First Clean Architecture
* ⚡ Riverpod state management
* 🌐 REST API integration with Dio
* 🔐 JWT authentication
* 🔒 Secure credential storage
* ❌ Functional error handling with Dartz
* 🛒 Complete E-Commerce shopping flow
* ❤️ Wishlist functionality
* ⭐ Product reviews and ratings
* 📍 Complete address management
* 💳 Cash & card order support
* 🌍 Multi-language support
* 📱 Responsive Flutter UI
* 🧩 Reusable components
* 📈 Scalable and maintainable architecture

---

# 📌 Conclusion

This E-Commerce application demonstrates how to build a **production-oriented Flutter application** using modern development practices.

By combining **Feature-First Clean Architecture, Riverpod, Dio, JWT authentication, secure storage, functional error handling, localization, and responsive UI**, the project provides a strong foundation for building scalable and maintainable mobile applications.

The architecture is designed so that new features can be added with minimal impact on existing modules while keeping the codebase organized and easy to understand.
