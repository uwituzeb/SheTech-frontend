# SheTech - Flutter Frontend

## Overview

SheTech is a mobile application designed to empower women in Rwanda by providing access to tech education, networking opportunities, and a supportive community. 
This Flutter-based frontend offers a comprehensive learning platform with features tailored to both learners and instructors.

## Features

### User Authentication:

  - Signup and login securely using email and password or using google authentication

### Homepage

  - Overview of the platform with quick access to courses, events, and community updates

### Courses

  - Browse a list of available courses
  - View detailed information about each course including lessons, resources and instructor information

### Events Calendar

  - View upcoming events, workshops, and networking opportunities

### Profile & Settings

  - Update user profile information
  - Manage account settings, including password and notification preferences

### Instructor Portal

  - Create and manage courses
  - Update existing course details, add lessons, and share resources

## Getting Started

### Prerequisites

- Flutter SDK (version 3.x or later)
- Android Studio / Xcode

### Installation

1. Clone the repository:

```

git clone https://github.com/uwituzeb/SheTech-frontend.git
cd SheTech-frontend
cd shetech_app

```

2.  Install dependencies

```

flutter pub get

```

3. Run the app

```

flutter run

```

## App Routes

The App inclues the following routes:

```

routes: {
  '/splash': (context) => SplashScreen(),
  '/welcome': (context) => const WelcomeScreen(),
  '/signup': (context) => const SignupScreen(),
  '/login': (context) => const LoginScreen(),
  '/forgot-password': (context) => const ForgotPasswordScreen(),
  '/reset-password': (context) => const ResetPasswordScreen(),
  '/create-password': (context) => const CreatePasswordScreen(),
},

```


