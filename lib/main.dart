import 'dart:developer';

import 'package:book_store/pages/Login.dart';
import 'package:book_store/pages/SignUp.dart';
import 'package:book_store/pages/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'components/BottomNavigation.dart';
import 'firebase_options.dart';

void main()async {
  //Initialise Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/splash",

      //Description of All the Routes
      routes: {
        "/splash":(context){return const SplashScreen();},
        "/signup":(context){return const SignUp();},
        "/login":(context){return const Login();},
        "/home": (context){return const BottomNavigation();}
      },
    );
  }
}
