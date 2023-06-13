import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz/home.dart';
import 'package:quiz/login.dart';
import 'package:quiz/profile.dart';
import 'package:quiz/register.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quiz',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/signup': (context) => Signup(),
        '/home': (context) => Home(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
