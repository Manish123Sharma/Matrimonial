# Matrimonial App

A modern matrimonial application built in **Flutter** that helps users find suitable matches. The app integrates with backend APIs for authentication, search, and profile management, providing a smooth and interactive user experience.

---

## Tech Stack

- **Frontend:** Flutter
- **State Management:** GetX
- **Backend Integration:** REST APIs
- **Local Storage & Persistence:** SharedPreferences / CookieJar
- **Networking:** Dio
- **Other Libraries:** dio_cookie_manager, get, fluttertoast

---

## Key Features

- **User Authentication:** Login and signup with API-based authentication.  
- **Profile Management:** View and edit user profiles.  
- **Search Functionality:** Search and filter profiles using API calls.  
- **Persistent Login:** Cookies and local storage to maintain session.  
- **Smooth UI:** Responsive and interactive UI using Flutter widgets.  
- **Error Handling:** Graceful handling of API errors and invalid inputs.  

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

## State Management & API Handling

- **State Management:** The app uses GetX for state management. Controllers are responsible for managing the state of different screens (e.g., `AuthController` for authentication, `SearchController` for search results).  
- **Reactive UI Updates:** UI components are updated reactively using `Obx` widgets, listening to changes in controller variables.  
- **API Handling:**  
  - **HTTP Requests:** Dio is used for making HTTP requests.  
  - **Session Management:** Cookies are managed using `dio_cookie_manager` for persistent sessions.  
  - **Response Handling:** API responses are parsed and stored in models.  
  - **Error Handling:** Toast messages are shown for failed requests or invalid inputs.  
- **Local Persistence:** Session cookies are saved locally to prevent the user from having to log in repeatedly.


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
- Screenshots section (you can replace with your actual images later)  
- Setup steps  
- API reference  
- Future improvements  
