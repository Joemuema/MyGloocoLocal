# Personalized Diabetes Management App
## Overview
This repository contains the source code for the Personalized Diabetes Management mobile application built using Flutter. The app provides users with tools for blood sugar logging, diet and meal planning, medication tracking, physical activity monitoring, and more.

## Prerequisites
Before you begin, ensure you have met the following requirements:
  -	**Flutter SDK:** Install Flutter SDK. [Installation Guide.](https://flutter.dev/docs/get-started/install)
  -	**Android Studio:** Install Android Studio. [Installation Guide.](https://developer.android.com/studio)
  -	**Git:** Install Git for version control. [Installation Guide.](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  -	**Java Development Kit (JDK):** Install JDK version 8 or higher. [Installation Guide.](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
    
## Getting Started
### 1. Clone the Repository
Open your terminal or command prompt and run the following command to clone the repository:

_git clone https://github.com/yourusername/your-repository-name.git_

Navigate into the project directory:

_cd your-repository-name_

### 2. Install Flutter Dependencies
In the project root directory, run the following command to install all necessary Flutter dependencies:
_flutter pub get_

### 3. Set Up Android Studio
**1.	Open Android Studio:**
  - Launch Android Studio and select Open an existing Android Studio project.
  -	Navigate to the cloned repository and select the project folder.
    
**2.	Set Up an Emulator:**
  -	Go to _Tools > AVD Manager_.
  -	Create a new virtual device by following the on-screen instructions.
  - Start the emulator.
    
**3.	Configure Flutter SDK in Android Studio:**
  -	Go to _File > Settings > Languages & Frameworks > Flutter_.
  -	Set the Flutter SDK path to the location where Flutter is installed on your machine.
    
### 4. Running the Application
***Option 1: Using Android Studio***
**1.	Select the Target Device:**
  -	At the top of Android Studio, select the device or emulator you wish to run the application on.
    
**2.	Run the App:**
  -	Click on the _Run_ button (green play icon) or press _Shift + F10_.

***Option 2: Using the Terminal***
**1.	Connect a Physical Device or Start an Emulator:**
  -	Make sure your device is connected or an emulator is running.
    
**2.	Run the Application:**
  -	Run the following command in the terminal:
    _flutter run_

### 5. Additional Configuration
***Configuring Firebase***

If your app uses Firebase services, you need to configure Firebase for your Android project:
1.	Go to the Firebase Console and create a new project or use an existing one.
2.	Download the _google-services.json_ file from your Firebase project and place it in the _android/app/<directory>_.
3.	Ensure the following lines are added in your _android/build.gradle_ and _android/app/build.gradle files_: 
  -	In _android/build.gradle_:
    
    	dependencies {_
   	
    	  classpath 'com.google.gms:google-services:4.3.10' // or latest version
   	
    	}
   	
  -	In _android/app/build.gradle_:
    
  	_apply plugin: 'com.google.gms.google-services'_

### 6. Testing the App
To run tests, execute:

_flutter test_

## Troubleshooting
If you encounter any issues while setting up or running the app, consider the following:
  -	Ensure your Flutter SDK and Android Studio are up to date.
  -	Run _flutter doctor_ to check if there are any unresolved issues and follow the provided suggestions.
  -	Check the official Flutter documentation or consult the Flutter community.
    
## Contributing
If you would like to contribute to this project, please fork the repository and create a pull request. Contributions are always welcome!

## License
This project is licensed under ***The Kenya Copyright Board (KECOBO)*** - see the LICENSE file for details.


