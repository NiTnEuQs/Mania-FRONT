import 'package:flutter/material.dart';
import 'package:mania/resources/dimensions.dart';

class Bloc extends StatelessWidget {
  Bloc({
    Key? key,
    this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.shadow = false,
    this.color = Colors.white,
    this.onTap,
  });

  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final bool shadow;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.blocCornerRadius)),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ]
            : [],
      ),
      padding: padding,
      child: InkWell(onTap: onTap, child: child),
    );
  }
}
