import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HoroscopoHomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBKul0UblGzfpVjcIlG4Nlspwb8buiUx7g",
      appId: "1:157563725722:android:fef8dad7712aa1be1f7c23",
      messagingSenderId: "157563725722",
      projectId: "com.example.horoscopo",
    ),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horóscopo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HoroscopoHomePage(),
    );
  }
}
