# Matrimonial App

A modern matrimonial application built in **Flutter** that helps users find suitable matches. The app integrates with backend APIs for authentication, search, and profile management, providing a smooth and interactive user experience.

---

## 🧰 Tech Stack

| Category | Technology |
|-----------|-------------|
| **Frontend** | Flutter |
| **State Management** | BLoC (Business Logic Component) |
| **Navigation** | GoRouter |
| **Networking** | Dio |
| **Persistence** | SharedPreferences, CookieJar |
| **Utilities** | dio_cookie_manager, fluttertoast, flutter_bloc |

---

## 🚀 Key Features

- 🔐 **User Authentication:** Secure login using API-based authentication.  
- 👤 **Profile Management:** View and manage user profiles.  
- 🔎 **Search Functionality:** Search and filter profiles using API integration.  
- 💾 **Persistent Login:** Session maintained with cookies & local storage.  
- 🧭 **GoRouter Navigation:** Clean and declarative routing across screens.  
- ⚡ **Responsive UI:** Smooth, consistent, and adaptive design.  
- 🧩 **Error Handling:** Graceful management of API/network errors.

---

## Installation & Running Locally

1. Clone the repository:

       git clone https://github.com/Manish123Sharma/Matrimonial.git
2. Navigate to the project folder:

       cd Matrimonial
3. Install dependencies:

       flutter pub get
   
5. Run the app on a connected device or emulator:

       flutter run

---

## API & External Services

- Authentication API: Handles user login and signup.
- Search API: Fetches search results for matching profiles.
- Other APIs: Profile details, updates, and session management.
- Cookies: Saved using cookie_jar for session persistence.

---

## 🧩 State Management (BLoC)

The app uses **BLoC (Business Logic Component)** for clean, testable, and predictable state management.

### 🔹 Highlights
- Each module (Auth, Search, etc.) has its own Event and State classes.
- Clear separation of **UI** and **business logic**.
- Real-time UI updates using **BlocBuilder** and **BlocListener**.
- Integration with **GoRouter** for reactive navigation.

### 🔹 Implemented Blocs
- **AuthBloc** → Handles login, logout, and cookie/session persistence.  
- **SearchBloc** → Manages search requests, loading states, and API responses.

---

## 🔗 API Handling

- **HTTP Requests:** Managed using Dio for reliable and structured API calls.
- **Session Management:** Cookies stored using dio_cookie_manager for persistent sessions.
- **Response Handling:** API responses parsed and displayed via the respective BLoCs.
- **Error Handling:** Toast or Snackbar messages show for any network or validation issues.

---

## 💾 Local Persistence

To keep users logged in until logout:

- **SharedPreferences** stores lightweight user preferences.  
- **CookieJar** manages authenticated sessions and cookies.  

This ensures a smooth experience — no repeated logins unless explicitly logged out.

---

## 📡 API Endpoints

| Feature                | Endpoint                        | Method     |
| ---------------------- | ------------------------------- | ---------- |
| **Login**              | `/api/login`                    | POST       |
| **Search**             | `/api/search/get-search-result` | POST       |
| **Profile Management** | `/api/profile/...`              | GET / POST |
| **Cookies**            | Managed via dio_cookie_manager  | —          |

All requests are authenticated with session cookies obtained during login.

---

## 🧭 Navigation — GoRouter

The app now uses GoRouter for declarative navigation:

- Clean routes (/login, /search, /profile)
- Automatic redirection after login/logout
- Seamless integration with BLoC for reactive navigation

---

## ScreenShots/Demo

[Drive Link](https://drive.google.com/drive/folders/1t5LYZAo2rpyNfvnCpJH1EuayvHLMUF_y?usp=sharing)

<img src="https://github.com/user-attachments/assets/20c824e3-b6c0-466f-b4fe-0c3288e72fd4" alt="Screenshot 1" width="300"/>
<img src="https://github.com/user-attachments/assets/e1540cf2-524a-4601-9747-cc5676de60ab" alt="Screenshot 2" width="300"/>
<img src="https://github.com/user-attachments/assets/9e3784bf-99a2-49fb-a183-b72aa0bc2e78" alt="Screenshot 3" width="300"/>
<img src="https://github.com/user-attachments/assets/579153c8-0797-4b58-aefa-7140d6ff2430" alt="Screenshot 4" width="300"/>

---

## **👨‍💻** **Author**

Manish Kumar Sharma

[📧 Email](mailto:your-mksharma256001@gmail.com) | [💼 LinkedIn](https://www.linkedin.com/in/mks001/) | [🌐 GitHub](https://github.com/Manish123Sharma)

---

##  📜 License

✅ This README includes:
- Features  
- Tech stack  
- Screenshots section
- Setup steps  
- API reference  
- Future improvements  
