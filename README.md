# Maw’ed 📅

**Maw’ed** is a mobile application built with **Flutter** that helps users manage appointments efficiently with a smooth and modern user experience.  
It is designed with scalability, maintainability, and user convenience in mind, following clean architecture principles and using **Bloc state management** for predictable and reactive UI behavior.

---

## 🚀 Features

- 🌍 **Multi-language support** — Arabic & English (using Flutter localization)
- 🌓 **Dynamic theming** — Light and Dark mode support
- 🧱 **Clean architecture** — Separation of presentation, domain, and data layers
- 🔔 **Smart notification system** — Local notifications to remind users of upcoming meetings and events
- 📅 **Calendar-based event organization** — Users can manage and view their appointments by date
- ⚡ **Responsive and adaptive UI** — Optimized for both Android and iOS
- 🧩 **Bloc pattern** — Ensures predictable state transitions and easier debugging

---

## 🧠 Technical Details

### 🏗 Architecture Overview
Maw’ed follows **Clean Architecture** with three main layers:
1. **Presentation Layer**  
   - Built using Flutter widgets with `Bloc` for state management (`flutter_bloc` package).  
   - Responsible for UI rendering and user interactions.

2. **Domain Layer**  
   - Contains **use cases**, **entities**, and **repositories interfaces**.  
   - Pure Dart code independent from Flutter SDK.

3. **Data Layer**  
   - Implements repository interfaces and handles local database operations using **`Shared Preferences`**.  
   - Manages CRUD operations for events, tasks, and notifications.

### 🧰 Tech Stack

| Category | Technology |
|-----------|-------------|
| Framework | Flutter (Dart) |
| State Management | Bloc / Cubit |
| Database | Shared Preferences |
| Notifications | Flutter Local Notifications |
| Theming | Dynamic light/dark modes |
| Internationalization | Flutter Localization (Intl) |
| Architecture | Clean Architecture Pattern |

---

## ⚙️ Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/mawed.git
