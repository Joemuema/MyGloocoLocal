# Personalized Diabetes Management App
## Overview
This repository contains the source code for the Personalized Diabetes Management mobile application built using Flutter. The app provides users with tools for blood sugar logging, diet and meal planning, medication tracking, physical activity monitoring, and more.
## Prerequisites
Before you begin, ensure you have met the following requirements:
  -	Flutter SDK: Install Flutter SDK. Installation Guide.
  -	Android Studio: Install Android Studio. Installation Guide.
  -	Git: Install Git for version control. Installation Guide.
  -	Java Development Kit (JDK): Install JDK version 8 or higher. Installation Guide.
## Getting Started
### 1. Clone the Repository
Open your terminal or command prompt and run the following command to clone the repository:
git clone https://github.com/yourusername/your-repository-name.git

Navigate into the project directory:
cd your-repository-name
### 2. Install Flutter Dependencies
In the project root directory, run the following command to install all necessary Flutter dependencies:
flutter pub get
### 3. Set Up Android Studio
1.	Open Android Studio:
o	Launch Android Studio and select Open an existing Android Studio project.
o	Navigate to the cloned repository and select the project folder.
2.	Set Up an Emulator:
o	Go to Tools > AVD Manager.
o	Create a new virtual device by following the on-screen instructions.
o	Start the emulator.
3.	Configure Flutter SDK in Android Studio:
o	Go to File > Settings > Languages & Frameworks > Flutter.
o	Set the Flutter SDK path to the location where Flutter is installed on your machine.
### 4. Running the Application
Option 1: Using Android Studio
1.	Select the Target Device:
o	At the top of Android Studio, select the device or emulator you wish to run the application on.
2.	Run the App:
o	Click on the Run button (green play icon) or press Shift + F10.
Option 2: Using the Terminal
1.	Connect a Physical Device or Start an Emulator:
o	Make sure your device is connected or an emulator is running.
2.	Run the Application:
o	Run the following command in the terminal:
3.	flutter run
### 5. Additional Configuration
Configuring Firebase
If your app uses Firebase services, you need to configure Firebase for your Android project:
1.	Go to the Firebase Console and create a new project or use an existing one.
2.	Download the google-services.json file from your Firebase project and place it in the android/app/ directory.
3.	Ensure the following lines are added in your android/build.gradle and android/app/build.gradle files: 
o	In android/build.gradle: 
o	dependencies {
o	  classpath 'com.google.gms:google-services:4.3.10' // or latest version
o	}
o	In android/app/build.gradle: 
o	apply plugin: 'com.google.gms.google-services'
### 6. Testing the App
To run tests, execute:
flutter test
## Troubleshooting
If you encounter any issues while setting up or running the app, consider the following:
•	Ensure your Flutter SDK and Android Studio are up to date.
•	Run flutter doctor to check if there are any unresolved issues and follow the provided suggestions.
•	Check the official Flutter documentation or consult the Flutter community.
## Contributing
If you would like to contribute to this project, please fork the repository and create a pull request. Contributions are always welcome!
## License
This project is licensed under The Kenya Copyright Board (KECOBO) - see the LICENSE file for details.


