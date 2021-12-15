import 'package:flutter/material.dart';

class RoundedOutline extends StatelessWidget {
  RoundedOutline({Key? key, this.child, this.color, this.width, this.height, this.padding, this.radius, this.onPressed});

  final Widget? child;
  final Color? color;
  final double? width, height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 25.0)),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(0.0),
            child: InkWell(
              onTap: onPressed,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
