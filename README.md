# Personalized Diabetes Management App
## Overview
This repository contains the source code for the Personalized Diabetes Management mobile application built using Flutter. The app provides users with tools for blood sugar logging, diet and meal planning, medication tracking, physical activity monitoring, and more.

## Prerequisites
Before you begin, ensure you have met the following requirements:

**Flutter SDK:** Install Flutter SDK. [Installation Guide.]([url](https://docs.flutter.dev/get-started/install))

**Android Studio:** Install Android Studio. [Installation Guide.]([url](https://developer.android.com/studio/install))

**Git:** Install Git for version control. [Installation Guide.]([url](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git))

**Java Development Kit (JDK):** Install JDK version 8 or higher. [Installation Guide.]([url](https://www.oracle.com/java/technologies/downloads/?er=221886))

## Getting Started
### 1. Clone the Repository
Open your terminal or command prompt and run the following command to clone the repository:

_git clone https://github.com/Joemuema/MyGloocoGit_

Navigate into the project directory:

_cd MyGloocoGit_

### 2. Install Flutter Dependencies
In the project root directory, run the following command to install all necessary Flutter dependencies:

_flutter pub get_

### 3. Set Up Android Studio
**Open Android Studio:**
Launch Android Studio and select Open an existing Android Studio project.

Navigate to the cloned repository and select the project folder.

**Set Up an Emulator:**
Go to Tools > AVD Manager.

Create a new virtual device by following the on-screen instructions.

Start the emulator.

**Configure Flutter SDK in Android Studio:**
Go to File > Settings > Languages & Frameworks > Flutter.

Set the Flutter SDK path to the location where Flutter is installed on your machine.

### 4. Running the Application
**Option 1: Using Android Studio**
Select the Target Device:

At the top of Android Studio, select the device or emulator you wish to run the application on.

Run the App:

Click on the Run button (green play icon) or press Shift + F10.

**Option 2: Using the Terminal**
Connect a Physical Device or Start an Emulator:

Make sure your device is connected or an emulator is running.

Run the Application:

Run the following commands in the terminal:

_flutter packages pub run build_runner build --delete-conflicting-outputs_

_flutter run_
