# MLBusca

![App Screenshot](MLBusca.gif)

iOS UIKit app to search and list Mercado Livre products.

## 🧑‍💻 Tech Stack & Architecture

- **UIKit**: chosen for compatibility with older iOS versions.
- **MVVM-C** pattern:
  - **Model**:
    - Codable structs to match API JSON data.
  - **ViewModel**:
    - Handles API calls via `APIService`.
    - Manages navigation via Coordinator.
  - **View**:
    - Pure code (no Storyboards/XIBs).
    - ViewControllers and custom Views.
    - Binds to ViewModel via `Combine` publishers.
    - Sends user actions to ViewModel.
  - **Coordinator**:
    - Owns `UINavigationController`.
    - Acts as a factory to assemble modules.
    - Handles navigation between modules.

- **Combine**: for reactive binding between View and ViewModel.
- **Swift Testing**: new framework used for Unit Testing (Xcode 16+).

## 📱 How to Run the App

1. Open the Xcode project.
2. Select a simulator.
3. Press `⌘ + R` (Run).

## 🧪 How to Run Tests

1. Open the Xcode project.
2. Select a simulator.
3. Press `⌘ + U` (Test).

## 🔮 Future Improvements

- Integrate real Mercado Livre API into `APIService`.
- Move all strings to `.strings` files for localization.
- Add accessibility hints for VoiceOver.
- Adopt system colors to support Dark Mode.

## 🛠 Requirements

- Xcode 16+
- iOS 15+
- Swift 5.5+
