import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    //Timer after which splash screen closes
    Timer(
        const Duration(seconds: 3),
            () {
              FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) {
                if (user == null) {
                  Navigator.popAndPushNamed(context, "/signup");
                } else {
                  Navigator.popAndPushNamed(context, "/home");
                }
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.book, size: 100,),
      ),
    );
  }
}
