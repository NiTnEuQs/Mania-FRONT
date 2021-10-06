import 'package:flutter/material.dart';
import 'package:mania/resources/herotags.dart';

class Logo extends StatelessWidget {
  Logo({Key key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: HeroTags.SPLASH_LOGO,
        child: Image.asset(
          'assets/images/ic_foreground.png',
        ),
      ),
    );
  }
}
