# 🌦️ Weather App

A **native iOS weather app** built using **UIKit and Swift 5**, providing **current weather** and **2-3 day forecasts**. It supports both **geolocation-based weather fetching** and **manual city input**. The app ensures smooth user experience through interactive animations and day/night-themed colors, following the **MVVM architecture** with no third-party dependencies.

---

## 🌟 Features

- **Weather for Current Location**

  - If the user grants **location permission**, the app fetches weather data for the current city.
  - Includes a **pull-to-refresh** option for refreshing the current location's weather.  
    _(Note: Pull-to-refresh will override manually entered city data.)_

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

## 📱 Preview

https://github.com/kishanbarmawala/Weather-App/blob/main/Preview/demo-1.png
| Few clouds | Clear sky | Night | Rain |
| :---------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------: |
| ![](https://github.com/kishanbarmawala/Weather-App/blob/main/Preview/demo-1.png) | ![](https://github.com/kishanbarmawala/Weather-App/blob/main/Preview/demo-2.png) | ![](https://github.com/kishanbarmawala/Weather-App/blob/main/Preview/demo-3.png) | ![](https://github.com/kishanbarmawala/Weather-App/blob/main/Preview/demo-4.mp4) |

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

## 💻 Screenshots

_(Add relevant screenshots or GIFs here to showcase animations and themes.)_

---

## 🤝 Contributing

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-branch
   ```
3. Make your changes and commit:
   ```bash
   git commit -m "Add new feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-branch
   ```
5. Open a pull request.

---

## 📝 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 📧 Contact

For any questions or suggestions, contact me at **kishanbarmawala7@gmail.com**.

---
