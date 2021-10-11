import 'package:flutter/material.dart';

class RoundOutline extends StatelessWidget {
  RoundOutline({Key? key, this.child, this.color, this.width, this.height, this.padding, this.onPressed});

  final Widget? child;
  final Color? color;
  final double? width, height;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 50.0,
      height: height ?? 50.0,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onPressed,
          child: child,
        ),
      ),
    );
  }
}
