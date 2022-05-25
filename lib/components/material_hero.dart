import 'package:flutter/material.dart';

class MaterialHero extends StatelessWidget {
  const MaterialHero({
    required this.tag,
    this.child,
    this.color,
  });

  final String tag;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(color: color ?? Colors.transparent, child: child),
    );
  }
}
