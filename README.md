# 🌦️ Weather App

[![Swift 5.0](https://img.shields.io/badge/Swift-5.10-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-green.svg?style=flat)](http://www.apple.com/ios/)

A **native iOS weather app**, providing **current weather** and **6 days forecasts**. It supports both **geolocation-based weather fetching** and **manual city input**. The app ensures smooth user experience through interactive animations and day/night-themed colors, following the **MVVM architecture** with no third-party dependencies.

---

## 🌟 Features

- **Weather for Current Location**

  - If the user grants **location permission**, the app fetches weather data for the current city.
  - By pressing gps floating button will fetch current location weather details.

- **Manual City Input**

  - If permission is denied or unavailable, the user can **manually search** for a city and view weather details.

- **Weather Forecast**

  - Provides **2-3 day forecasts** for the selected location.

- **Interactive Animations & Themes**

  - Displays **weather-based animations** for conditions like rain.
  - **Day and night themes** based on the selected location’s time.

- **Error Handling**

  - Handles **invalid city names** gracefully with user-friendly messages.
  - Displays a **"No Internet"** message if there is no network connection.

- **Minimal Dependency**
  - No third-party libraries used; the project leverages **UIKit** and native APIs for all functionalities.

---

## 📱 Screenshots

Preview 1                  | Preview 2                 | Preview 3                 | Preview 4                  
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
| ![](https://github.com/kishanbarmawala/Weather-App/blob/main/Preview/demo-1.png) | ![](https://github.com/kishanbarmawala/Weather-App/blob/main/Preview/demo-2.png) | ![](https://github.com/kishanbarmawala/Weather-App/blob/main/Preview/demo-3.png) | ![](https://github.com/kishanbarmawala/Weather-App/blob/main/Preview/demo-4.gif) |

---

## 📋 Data Displayed

- **Current Temperature**
- **Minimum and Maximum Temperature**
- **Pressure**
- **Visibility**
- **Humidity**
- **Weather Overview**
- **Date and Time**
- **Weather Icons** (if available)

---

## 🛠️ Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture, ensuring:

- Clear separation between UI and business logic.
- Maintainable and scalable code.
- Easier testing and future enhancements.

---

## 🚀 Getting Started

1. **Clone the Repository**

   ```bash
   git clone https://github.com/your-username/weather-app.git
   cd weather-app
   ```

2. **Open in Xcode**  
   Open the `.xcodeproj` file in Xcode.  
   Make sure you have **Xcode 13+** installed.

3. **Run the App**  
   Connect a simulator or device, and hit **Run** (`Cmd + R`).

4. **Grant Location Permissions**  
   The app will request location permission to display the weather for the current location. If denied, you can manually search for city weather.

---

## ⚠️ Error Handling

- **Location Permission Denied**  
  Displays an error message, but the user can still search manually for weather information.

- **No Internet Connection**  
  Shows a **"No Internet"** message if the network is unavailable.

- **Invalid City Name**  
  Displays a **"City not found"** message when the input city is unrecognized.

---

## 📝 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 📧 Contact

For any questions, feedback, or suggestions, please reach out to me at:

- Email: [kishanbarmawala7@gmail.com](mailto:kishanbarmawala7@gmail.com)
- LinkedIn: [Kishan Barmawala](https://www.linkedin.com/in/kishan-barmawala/)

Your thoughts are greatly appreciated!

---
