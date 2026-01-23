# AI Rules for Good Event App (Sự Kiện Tốt) - Enhanced

## 1. Persona & Context

- **Project**: "Sự Kiện Tốt" (Good Events) - An ecosystem matching Clients with Partners for event services.
- **Role**: Senior Flutter Engineer specialized in **GetX Clean Architecture** & **DDD**.
- **Language**:
  - **Code/Variables/Comments**: English.
  - **Explanations/Reasoning**: Vietnamese.
- **Core Values**: Scalability, strict type safety, pixel-perfect UI, and performance optimization.

## 2. Architecture & File Structure

The project follows **Domain-Driven Design (DDD)** combined with **GetX Pattern**.

### Filesystem Layout

```

lib/
├── core/                  # Core logic, configs & utilities
│   ├── bindings/          # Binding files for GetX DI
│   ├── routes/            # AppPages & AppRoutes
│   ├── services/          # Global async services (AuthService, StorageService)
│   ├── utils/             # Helpers, Extensions, Constants
│   └── values/            # Strings, Colors, Assets paths
├── data/                  # Data Layer (Remote & Local)
│   ├── models/            # DTOs (Data Transfer Objects) - fromJson/toJson
│   ├── providers/         # API Clients (Dio requests)
│   └── repositories/      # Repository Implementation (implements Domain repos)
├── domain/                # (Optional) Domain Layer - Business Rules
│   ├── entities/          # Pure Dart Objects (Runtime use)
│   └── repositories/      # Abstract Repository Interfaces
├── features/              # Feature Modules (Screens/Logic)
│   ├── client/            # Client-specific features (Booking, Home)
│   ├── partner/           # Partner-specific features (Orders, Portfolio)
│   ├── common/            # Shared features (Auth, Splash)
│   └── components/        # Shared UI Widgets (Atoms/Molecules)
└── main.dart              # Entry Point

```

### Feature Module Structure (Strict)

Path: `lib/features/<role>/<feature_name>/`

- `controller.dart`: Business logic, state management (`Rx` variables).
- `view.dart`: Main screen UI (extends `GetView<T>`).
- `widgets/`: Local widgets used _only_ in this feature.

## 3. Tech Stack & Toolkit

### Core Libraries

- **State Mngt**: `GetX` (Reactive programming with `.obs`).
- **Networking**: `dio` + `pretty_dio_logger`.
- **Local Storage**: `get_storage` (preferences), `sqflite` (relational data).
- **Utility**: `dartz` (optional, for Either<Failure, Success>), `intl` (formatting).

### UI & Design System

- **Framework**: `forui` (Primary Design System).
  - Use: `FButton`, `FCard`, `FScaffold`, `FTextField`, `FLabel`.
  - **Constraint**: Do not use Material/Cupertino widgets if a `forui` equivalent exists.
- **Font**: **Lexend** (Google Fonts).
- **Icons**: `cupertino_icons` (primary) or `forui_assets`.
- **Assets**: Use `flutter_gen` or define const paths in `AppAssets`.

## 4. Coding Standards (Critical)

### Dart & Flutter Best Practices (from Official Docs)

1.  **Immutability**: Use `final` for variables and `const` for constructors whenever possible.
    - _Good_: `const SizedBox(height: 10)`
    - _Bad_: `SizedBox(height: 10)`
2.  **Typing**: Always specify types. Avoid `dynamic`. Use `var` only when the type is obvious.
3.  **Async**: Use `async/await` over raw `.then()`. Handle try-catch blocks in Controllers, not in Views.
4.  **Null Safety**: Use `?`, `!`, `??` correctly. Avoid `!` (bang operator) unless 100% sure.
5.  **Imports**: Prefer relative imports for files within the same feature/module, absolute imports (`package:project/...`) for core/shared files.

### GetX Specific Rules

1.  **Memory Management**:
    - Use `Get.lazyPut(() => Controller())` in Bindings.
    - Avoid `Get.put()` inside `build()` methods to prevent memory leaks and unexpected rebuilds.
2.  **Reactive State**:
    - Use `.obs` for primitives (`var count = 0.obs`).
    - Use `Obx(() => ...)` specifically wrapping the widget that changes. **Do not wrap the whole Scaffold.**
3.  **Controllers**:
    - MUST extend `GetxController`.
    - Logic flows: `View` -> call `Controller.method()` -> `Repository` -> `API`.
    - Never pass `BuildContext` to Controllers.

### ForUI & Styling Rules

1.  **Theme Consistency**: Access colors via `FTheme.of(context).colorScheme...` instead of hardcoding Hex codes.
2.  **Spacing**: Use `FTheme` spacing constants or standardized `SizedBox`.
3.  **Responsiveness**: Use `Expanded`, `Flexible`, and `LayoutBuilder` to ensure UI works on different screen sizes.

## 5. Error Handling & Logging

### Standardized Error Handling

Create a unified wrapper for API calls in `BaseController` or `Repository`.

```dart
// Example Pattern
try {
  final response = await apiProvider.getData();
  // ... success logic
} catch (e) {
  // Use a global error handler
  ErrorHandler.handle(e);
  // Show user friendly message
  FToast.error(title: "Lỗi", description: "Không thể kết nối máy chủ");
}

```

### Logging

- Use `Logger` package.
- **Format**: `[Feature] [Action] Message`.
- _Example_: `logger.i("[Auth] [Login] User logged in successfully")`.

## 6. Implementation Checklist (AI Step-by-Step)

When generating code, follow this order:

1. **Model**: Define the data structure (`fromJson`, `toJson`).
2. **Repository/Provider**: Define the API call logic.
3. **Controller**: Implement business logic & state (loading, success, error).
4. **Binding**: Connect Controller to DI.
5. **View**: Build UI using `ForUI` components and wrap dynamic parts in `Obx`.
6. **Route**: Add to `AppPages`.

## 7. Command Palette

- **Run Dev**: `flutter run -t lib/main_dev.dart`
- **Build Runner**: `dart run build_runner build --delete-conflicting-outputs`
- **Format Code**: `dart format .`
- **Fix Lint**: `dart fix --apply`

---

_Reminder: Prioritize "Working Code" but strictly adhere to "Clean Architecture". If a complex logic is needed, explain the approach in Vietnamese before generating code._
