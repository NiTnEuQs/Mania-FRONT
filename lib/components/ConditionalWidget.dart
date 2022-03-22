import 'package:flutter/material.dart';

class ConditionalWidget extends StatelessWidget {
  const ConditionalWidget({
    Key? key,
    required this.conditions,
    this.child,
    this.loader,
    this.displayLoader = true,
    this.circleColor = Colors.white,
  }) : super(key: key);

  final bool conditions;
  final Widget? child, loader;
  final bool displayLoader;
  final Color? circleColor;

  @override
  Widget build(BuildContext context) {
    return conditions
        ? (child ?? Container())
        : (displayLoader
            ? (loader ??
                Center(
                  child: CircularProgressIndicator(
                    color: circleColor,
                  ),
                ))
            : Container());
  }
}
