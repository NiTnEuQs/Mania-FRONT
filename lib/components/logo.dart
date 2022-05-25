import 'package:flutter/material.dart';
import 'package:mania/resources/hero_tags.dart';

class Logo extends StatelessWidget {
  const Logo();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: HeroTags.splashLogo,
      child: Image.asset(
        'assets/images/ic_foreground.png',
      ),
    );
  }
}
