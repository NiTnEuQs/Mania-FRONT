import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mania/app/Prefs.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/logo.dart';
import 'package:mania/handlers/FirebaseHandler.dart';
import 'package:mania/handlers/TwitchHandler.dart';
import 'package:mania/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _nextScreenRequirements = 0;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 64.0),
          child: Center(
            child: Logo(),
          ),
        ),
      ),
    );
  }

  initialize() {
    Future.delayed(Duration(seconds: 1), () {
      Prefs.initialize().then((value) {
        // initializeDateFormatting(System.countryCode, null).then((value) {
        initializeFirebase();
        initializeTwitch();
        // });
      });
    });
  }

  initializeFirebase() {
    _nextScreenRequirements++;
    FirebaseHandler.initialize(context: context).then((value) {
      onInitializationFinished();
    });
  }

  initializeTwitch() {
    _nextScreenRequirements++;
    TwitchHandler.initialize(context: context).then((success) {
      if (success) {
        onInitializationFinished();
      }
    }).catchError((error) {});
  }

  onInitializationFinished() {
    if (--_nextScreenRequirements == 0) {
      LoginScreen.loadNextScreen(context);
    }
  }
}
