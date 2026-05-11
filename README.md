# 🌸 UI Farm – Áo Dài E-Commerce App

> A feature-rich mobile e-commerce application for traditional Vietnamese Áo Dài, built with Flutter and Clean Architecture.

---

## 📱 Screenshots

| Login | Register | Home |
|---|---|---|
| <img width="300" height="600" alt="Screenshot_1778423334" src="https://github.com/user-attachments/assets/edd64282-e519-4d77-af5a-d0e01c1782ec" /> | <img width="300" height="600" alt="Screenshot_1778423454" src="https://github.com/user-attachments/assets/7a9ee9e9-eef8-43c5-b741-fa5b50ab4e9f" /> | <img width="300" height="600" alt="Screenshot_1778423532" src="https://github.com/user-attachments/assets/b7148d0a-e2cd-405b-9832-4c183bddb58a" />  <img width="300" height="600" alt="Screenshot_1778423515" src="https://github.com/user-attachments/assets/d6e5159f-0280-4e9f-881d-972f652ce305" /> |

| Product List | Cart |
|---|---|
| <img width="300" height="600" alt="Screenshot_1778424199" src="https://github.com/user-attachments/assets/873c3a2d-51ad-43fb-8edf-b98c1c624c9a" /> |  <img width="300" height="600" alt="Screenshot_1778424118" src="https://github.com/user-attachments/assets/4d4505e1-b1d8-474e-92a7-78fe17ca00e6" /> |

| Order Management | Profile | Contact |
|---|---|---|
| <img width="300" height="600" alt="Screenshot_1778424089" src="https://github.com/user-attachments/assets/a846317f-8397-4848-ad2a-93a8ee0a8e7f" /> | <img width="300" height="600" alt="Screenshot_1778423960" src="https://github.com/user-attachments/assets/3751ca29-2218-454d-803a-13adee049240" /> | <img width="300" height="600" alt="Screenshot_1778423995" src="https://github.com/user-attachments/assets/013683ad-0df4-4ac6-95d7-883f5114eafe" /> |

---

## ✨ Features

- **Authentication** — Login, Register with JWT Bearer Token
- **Product Browsing** — Browse products with filter by color, gallery/collection, and price range
- **Pagination** — Infinite scroll / load more for product list
- **Product Detail** — View full product details with image gallery, color and material selection
- **Shopping Cart** — Add to cart, update quantity, remove items
- **Order Management** — View order history with status tracking (Pending / Approved / Cancelled)
- **Profile Management** — Update personal info (name, phone, avatar)
- **Responsive Navigation** — Tab-based navigation with nested routes, animated bottom bar hide/show on scroll

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns across three layers:

```
lib/
├── config/               # App configuration & initialization
├── di/                   # Dependency Injection setup (GetIt + Injectable)
├── domain/               # Business logic layer
│   ├── entities/         # Pure Dart domain models
│   ├── repositories/     # Abstract repository interfaces
│   └── usecases/         # Single-responsibility use cases
│       ├── auth/
│       ├── item/
│       ├── cart/
│       └── order/
├── data/                 # Data layer
│   ├── api/
│   │   ├── models/       # API response data models (Freezed + JSON)
│   │   ├── mapper/       # Data ↔ Domain mappers
│   │   └── interceptors/ # Dio interceptors (Auth, Logging)
│   ├── repositories/     # Repository implementations
│   └── app_api_service.dart
├── shared/               # Shared utilities
│   ├── base/             # BaseBloc, BaseUseCase, BaseDataMapper, BasePageState
│   ├── enums/            # RestMethod, etc.
│   └── exceptions/       # AppException, RemoteException, ServerError
├── resources/            # Assets, fonts, localization
└── ui/                   # Presentation layer
    ├── app/              # AppBloc (global state)
    ├── views/
    │   ├── login/
    │   ├── register/
    │   ├── home/
    │   ├── list_item/
    │   ├── item_detail/
    │   ├── cart/
    │   ├── order_management/
    │   ├── profile/
    │   └── contact/
    └── widgets/          # Reusable widgets
```

### Data Flow

```
View → Event → BLoC → UseCase → Repository (interface)
                                      ↓
                              Repository Impl → API / Local Storage
                                      ↓
                              Data Model → Mapper → Domain Entity
                                      ↓
                              BLoC emits State → View rebuilds
```

---

## 🛠️ Tech Stack

| Category | Library | Purpose |
|----------|---------|---------|
| **Framework** | Flutter 3.x | Cross-platform UI |
| **State Management** | flutter_bloc | BLoC pattern |
| **Dependency Injection** | get_it + injectable | Service locator & DI |
| **Code Generation** | freezed + json_serializable | Immutable models & JSON |
| **Networking** | dio | HTTP client |
| **Navigation** | auto_route | Type-safe routing |
| **Secure Storage** | flutter_secure_storage | JWT token storage |
| **Image Carousel** | carousel_slider | Home banner slider |
| **Image Picker** | image_picker | Avatar upload |
| **Reactive Streams** | rxdart | Event transformers |
| **Concurrency** | bloc_concurrency | BLoC event transformers |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/ui_farm_app.git
cd ui_farm_app

# Install dependencies
flutter pub get

# Run code generation
make build_all

# Run the app
flutter run
```

---

## ⚙️ Environment

| Key | Value |
|-----|-------|
| Base URL | `https://ui-farm-be-main-1.onrender.com/ui-farm` |
| Auth | Bearer JWT Token |
| Min Android SDK | 24 |
| Min iOS | 15.0 |

---

## 📦 Key Patterns

### BLoC Pattern
Every screen has its own BLoC with `Event → State` flow:
```dart
// Dispatch event
bloc.add(const LoginButtonPressed());

// Listen to state
BlocBuilder<LoginBloc, LoginState>(
  buildWhen: (p, c) => p.isLoading != c.isLoading,
  builder: (context, state) => ...,
)
```

### Use Case Pattern
```dart
@injectable
class LoginUseCase extends BaseFutureUseCase<LoginInput, LoginOutput> {
  @override
  Future<LoginOutput> buildUseCase(LoginInput input) async {
    final user = await _authRepository.login(
      email: input.email,
      password: input.password,
    );
    return LoginOutput(user: user);
  }
}
```

### Repository Pattern
```dart
// Domain layer — abstract interface
abstract class AuthRepository {
  Future<User> login({required String email, required String password});
}

// Data layer — implementation
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository { ... }
```

---

## 🗂️ API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/auth/login` | User login |
| `POST` | `/users` | User register |
| `GET` | `/users/me` | Get current user |
| `PUT` | `/users/:id` | Update profile |
| `GET` | `/items` | Get all items |
| `GET` | `/items/filter/` | Filter items (color, gallery, price, page) |
| `GET` | `/galleries` | Get all galleries/collections |
| `GET` | `/cart/` | Get user cart |
| `PATCH` | `/cart/remove` | Remove item from cart |
| `PATCH` | `/cart/updateQuantity` | Update cart item quantity |
| `GET` | `/payment` | Get order history |

---

## 📄 License

This project is for personal/portfolio purposes.

---

<p align="center">Made with ❤️ in Ho Chi Minh City 🇻🇳</p>
