# SheTech Flutter Mobile App

## Overview

SheTech is a mobile application designed to empower women in Rwanda by providing access to tech education, networking opportunities, and a supportive community. 
This Flutter-based app offers a comprehensive learning platform with features tailored to both learners and instructors, powered by Firebase for real-time data synchronization and authentication.

## Features

### User Authentication:

  - Signup and login securely using email and password or using google authentication
  - Password reset functionality

### Homepage

  - Overview of the platform with quick access to courses, events, and community updates
  - Real-time updates using Firebase Firestore

### Courses

  - Browse a list of available courses
  - View detailed information about each course including lessons, resources and instructor information
  - Course materials stored in Firebase Storage

### Events Calendar

  - View upcoming events, workshops, and networking opportunities
  - Real-time event updates

### Profile & Settings

  - Update user profile information
  - Logout of account
### Instructor Portal

  - Create and manage courses
  - Update existing course details, add lessons, and share resources
  - Real-time course updates using Firebase

## Download APK
[Download the latest APK](https://drive.google.com/file/d/1WfyXty4RWHKcOwMKFixC23a0c8hCCRwD/view?usp=drive_link)

## Getting Started

### Prerequisites

- Flutter SDK (version 3.x or later)
- Android Studio / Xcode
- Firebase account
- `google-services.json` (Android)

### Installation

1. Clone the repository:

```

git clone https://github.com/uwituzeb/SheTech-frontend.git
cd SheTech-frontend
cd shetech_app

```
2. Set up Firebase

- Create new project in firebase console
- Enable authentication (Email/Password and Google Sign-In)
- Set up Cloud Firestore
- Download and add `google-services.json` to `android/app/` 


3.  Install dependencies

```

flutter pub get

```

4. Run the app

```

flutter run

```

## Project Structure

```
/lib
  |-- authentication/          # Authentication i.e signup, login and reset password screens
  |-- events/              # Events and calendar screens
  |-- instructor/             # instructor page screens
  |-- learners/            # learners courses page screen
  |-- splash/               # splash screen and welcome page widgets
  |-- settings/               # settings and profile widgets
  |-- services/            # Firebase services
      |-- 
  |-- main.dart            # Entry point of the application
  |-- homepage.dart             # homepage widget
```

## Security Rules

The project uses Firebase Firestore with comprehensive security rules to protect data access:

## User Authentication Rules

- Users can only read and write their own user document
- Authentication is required for most operations

## Collection-specific Rules

- Users: Read/write only for the authenticated user
- Courses:
  - Read access for all signed-in users
  - Create/update only for instructors


## Lessons:

- Public read access
- Create/update requires authentication

## App Routes

The App includes the following routes:

```

routes: {
'/home': (context) =>const HomeScreen(),
'/splash': (context) => const SplashScreen(),
'/welcome': (context) => const WelcomeScreen(),
'/signup': (context) => const SignupScreen(),
'/login': (context) => const LoginScreen(),
'/forgot-password': (context) => const ForgotPasswordScreen(),
'/reset-password': (context) => const ResetPasswordScreen(),
'/create-password': (context) => const CreatePasswordScreen(),
'/book-event': (context) => const BookingScreen(),
'/instructor/courses': (context) => const CourseListPage(),
'/instructor/landing_page': (context) => const InstructorHomeScreen(),
'/instructor/editing_course': (context) => const EditCourseScreen(course: {}),
'/profile': (context) => const ShetechProfile(),
'/settings': (context) => const SettingScreen(),
'/calendar': (context) => const CalendarPageScreen(),
'/courses': (context) => const CourseListPageScreen()
},

```

## Dynamic Links

The application handles dynamic links, specifically for password reset:

- When a password reset link is clicked, it navigates to `/create-password` with the reset code


## Contributing

Contributions are welcome! If you want to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix:
   
`git checkout -b feature/your-feature-name`

3. Make your changes and commit them:
   
`git commit -m "Add feature: your feature name"`

4. Push to your branch:
   
`git push origin feature/your-feature-name`

5. Open a Pull Request.

## TEAM MEMBERS

1. Uwituze Bernice
2. Eliane Munezero
3. Gentille Umutoni
4. Kangabire Muhoza Merveille
5. Mpano Umumararungu Cynthia
6. Oden Emmanuel Mbang




