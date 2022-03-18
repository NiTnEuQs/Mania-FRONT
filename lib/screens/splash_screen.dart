import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:mania/app/Prefs.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/logo.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/handlers/FirebaseHandler.dart';
import 'package:mania/handlers/TwitchHandler.dart';
import 'package:mania/screens/login_screen.dart';

class SplashScreen extends BaseStatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
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
        Future.wait([
          FirebaseHandler.initialize(),
          TwitchHandler.initialize(),
        ]).then((List responses) {
          onInitializationFinished();
        }).catchError((e) {
          print('Error: $e');
        });
        // });
      });
    });
  }

  onInitializationFinished() {
    LoginScreen.nextScreen(context);
  }
}
