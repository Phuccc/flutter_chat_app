# Chat Friendly App

The Chat Friendly App is a robust and user-friendly platform that allows you to send and receive messages with your friends and family. With a sleek design and intuitive interface, the app provides a seamless communication experience on your mobile device.

## Features

- **Real-Time Messaging**: Send and receive messages instantly with your contacts.
- **Firebase Integration**: The app leverages Firebase services for seamless integration, including:
  - **Firebase Authentication**: Secure user authentication and management.
  - **Firebase Firestore**: Real-time database for storing and syncing conversation data.
  - **Firebase Cloud Messaging**: Reliable push notifications for instant message delivery.
  - **Firebase Storage**: Secure storage for user-uploaded media files.

## Sreenshots

<div style="display:flex"> 
  <img src="https://github.com/Phuccc/flutter_chat_app/assets/87201033/a2a7e4a4-6d3a-4dcc-9944-ff35f278a953" width="200" height="400"/> 
  <img src="https://github.com/Phuccc/flutter_chat_app/assets/87201033/aa60a863-aa6a-48da-83bd-9f02b59cf8ad" width="200" height="400"/> 
  <img src="https://github.com/Phuccc/flutter_chat_app/assets/87201033/7dd7207d-f1bd-43cf-a215-f0d4a1dff9f7" width="200" height="400"/> 
  <img src="https://github.com/Phuccc/flutter_chat_app/assets/87201033/71bdb06d-df2a-4138-9c4d-ada601390c9b" width="200" height="400"/> 
  <img src="https://github.com/Phuccc/flutter_chat_app/assets/87201033/55347349-f464-4ec4-94c1-a9b64a023103" width="200" height="400"/> 
  <img src="https://github.com/Phuccc/flutter_chat_app/assets/87201033/793de535-25b0-41d4-8aa7-830272fd595e" width="200" height="400"/> 
  <img src="https://github.com/Phuccc/flutter_chat_app/assets/87201033/b19b22c6-4974-4643-823b-1a5f25f4511f" width="200" height="400"/> 
</div>

## Getting Started

Before you begin, ensure you have met the following requirements:

- You have installed [Flutter](https://flutter.dev/docs/get-started/install) on your local machine.
- You have a Firebase project set up. If not, create one [here](https://console.firebase.google.com/).

1. **Clone the repository:**
    ```sh
    git clone https://github.com/Phuccc/flutter_chat_app.git
    cd flutter_chat_app
    ```

2. **Install dependencies:**
    ```sh
    flutter pub add firebase_core
    flutter pub add firebase_auth
    flutter pub add cloud_firestore
    flutter pub add firebase_messaging
    flutter pub add image_picker
    flutter pub add firebase_storage
    flutter pub get
    ```

3. **Set up Firebase:**
    - Go to the Firebase Console and create a new project.
    - Enable Authentication (Email/Password) in the Authentication section.
     ```sh
    npm install -g firebase-tools
    firebase login
    dart pub global activate flutterfire_cli
    flutterfire configure
    ```
   - Select the newly created Firebase project to use.
  
4. **Run main.dart**
     - Take the FCM token to use Cloud Messaging.
  
