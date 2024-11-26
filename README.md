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
  - 
### Instructor Portal

  - Create and manage courses
  - Update existing course details, add lessons, and share resources
  - Real-time course updates using Firebase

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

The App allows two roles for users i.e learners and instructors, hence requires security rules for role-based access control, protection of user data
, Controlled access to courses, enrollments, and progress as well as prevent unauthorized data modifications.

- Only authenticated users can access specific parts of your database
- Learners and instructors will have different levels of data access
- Some actions are restricted according to user role


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
'/profile': (context) => const ShetechProfile(),
'/settings': (context) => const SettingScreen(),
'/calendar': (context) => const CalendarPageScreen(),
'/courses': (context) => const CourseListPageScreen()
},

```

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




