# student-progress-tracker

To run the project:
- - - - - - - - - - - - - - - - - -
cd student_progress_tracker \n
flutter pub get \n
flutter run \n

# 📚 Student Progress Tracker App

A simple Flutter application to track student progress using dummy user data. It includes a secure login system and provides information like attendance percentage, current courses, and upcoming tests.

## 🛠️ Tech Stack

- **Flutter** (UI Framework)
- **flutter_bloc** (State Management)
- **flutter_secure_storage** (Secure Login Storage)

## 📱 Features

- 🔐 **Login Page**  
  Secure login with dummy credentials using `flutter_secure_storage`.

- 🏠 **Home Page**  
  Displays:
  - Student's Name and ID
  - Attendance Percentage
  - List of Current Courses
  - Upcoming Tests and their details

- 👤 **Profile Page**  
  - Displays basic user info (name, ID)
  - Optionally editable fields (if implemented)

## 🔑 Dummy Login Credentials

You can log in using any of the predefined dummy user credentials:

ID: 10001
Password: pankaj@2025

ID: 10002
Password: anjali#8821

ID: 10003
Password: rohanM95!

ID: 10004
Password: sneha_85ss

ID: 10005
Password: aryan!cs12


## 📂 Project Structure
lib/
├── bloc/ # State management using Cubit
│ └── data_cubit.dart
│
├── data/ # Dummy data used in the app
│ ├── auth/
│ │ └── credentials.dart # Stores dummy login IDs & passwords
│ └── students/
│ └── students_raw_data.dart # Stores student profile & academic data
│
├── routes/
│ └── routes.dart # Manages app navigation
│
├── screens/ # UI screens
│ ├── homepage.dart
│ ├── login.dart
│ ├── profile.dart
│ └── splash.dart
│
├── sdk/
│ └── responsive_sdk.dart # Makes UI responsive across devices
│
└── main.dart # App entry point
