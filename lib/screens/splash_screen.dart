import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/app/prefs.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/logo.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/handlers/firebase_handler.dart';
import 'package:mania/handlers/twitch_handler.dart';
import 'package:mania/screens/login_screen.dart';

class SplashScreen extends BaseStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    initialize(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 64.0),
          child: const Center(
            child: Logo(),
          ),
        ),
      ),
    );
  }

  void initialize(WidgetRef ref) {
    Future.delayed(const Duration(seconds: 1), () {
      Prefs.initialize().then((value) {
        Prefs.setup(ref);
        // initializeDateFormatting(System.countryCode, null).then((value) {
        Future.wait([
          FirebaseHandler.initialize(),
          TwitchHandler.initialize(),
        ]).then((List responses) {
          onInitializationFinished();
        }).catchError((e) {
          if (kDebugMode) {
            print('Error: $e');
          }
        });
        // });
      });
    });
  }

  void onInitializationFinished() {
    LoginScreen.nextScreen(context);
  }
}
