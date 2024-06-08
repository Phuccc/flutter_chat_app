// ignore_for_file: await_only_futures, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth/auth_gate.dart';
import 'package:flutter_chat_app/firebase_options.dart';
import 'package:flutter_chat_app/services/notification/notification_service.dart';
import 'package:flutter_chat_app/themes/light_theme.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService().requestNotification();
  NotificationService().foregroundMessages();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('Token: $fcmToken');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const AuthGate(),
    );
  }
}
